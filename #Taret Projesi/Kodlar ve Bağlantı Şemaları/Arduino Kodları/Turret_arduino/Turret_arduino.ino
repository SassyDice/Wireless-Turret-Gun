#include <Servo.h>

// Alper Burak PUSAR - 1030520446

//-----Servoları ve değişkenleri bildirme

Servo pan_servo;
Servo tilt_servo;
Servo recoil_servo;

const byte tilt_limit_1 = 65;
const byte tilt_limit_2 = 180;
const byte pan_limit_1 = 0;
const byte pan_limit_2 = 180;
const byte recoil_rest = 180;    // Hareketsizken servo açısı
const byte recoil_pushed = 125;  // Mermiyi itmesi için servonun ulaşması gereken açı

//-----Seri veri işleme ile ilgili değişkenler
byte byte_from_app;
const byte buffSize = 30;
byte inputBuffer[buffSize];
const byte startMarker = 255;
const byte endMarker = 254;
byte bytesRecvd = 0;
boolean data_received = false;

//-----Motor zamanlaması ve ateşleme ile ilgili değişkenler
bool is_firing =  false;
bool can_fire =  false;
bool recoiling = false;

unsigned long firing_start_time = 0;
unsigned long firing_current_time = 0;
const long firing_time = 150;

unsigned long recoil_start_time = 0;
unsigned long recoil_current_time = 0;
const long recoil_time = 2 * firing_time;

const byte motor_pin =  12;
boolean motors_ON = false;

//8===========================D

void setup()
{
  //-----motor pimi modunu tanımlama
  pinMode(motor_pin, OUTPUT);
  digitalWrite(motor_pin, LOW);

  //-----servoyu pinlere bağlama (Arduino Nano'da bu pinlerde pwn özelliği bulunmaktadır.)
  recoil_servo.attach(9);
  pan_servo.attach(10);
  tilt_servo.attach(11);

  //-----başlangıç sırası
  recoil_servo.write(recoil_rest);
  pan_servo.write(90);
  //tilt_servo.write(tilt_limit_2);
  delay(1000);
  //tilt_servo.write(tilt_limit_2 + abs((tilt_limit_2 - tilt_limit_1)/2));
  tilt_servo.write(105);


  Serial.begin(9600);  // seri haberleşmeyi başlatma
}

//8===========================D

void loop()
{
  getDataFromPC();
  set_motor();
  if (data_received) {
    move_servo();
    set_recoil();
    set_motor();
  }
  fire();
}

//8===========================D

void getDataFromPC() {

  //verilerin beklenen yapısı [başlangıç baytı, yatay miktarı, dikey miktarı, motor açık, ateşleme düğmesine basıldı, son bayt]
  //başlangıç baytı = 255
  //yatay miktarı = 0 ve 253 bayt aralığında
  //dikey miktarı = 0 ve 253 bayt aralığında
  //motor açık = 0 kapalı - 1 açık
  //ateşleme düğmesine basıldı = herhangi basım olmaması durumunda 0 - tersi için 1
  //end byte = 254

  if (Serial.available()) {  // Seri halinde veri mevcutsa

    byte_from_app = Serial.read();   //bir sonraki karakteri oku

    if (byte_from_app == 255) {     // bulunursa başlangıç baytını ara
      bytesRecvd = 0;                   //alınan baytı 0'a sıfırla
      data_received = false;
    }

    else if (byte_from_app == 254) {    // eğer bulunursa, bitiş baytını arayın
      data_received = true;                // verilerin kullanılabilmesi için data_received öğesini true olarak ayarlama
    }

    else {                            // arabelleğe alınan baytı ekle
      inputBuffer[bytesRecvd] = byte_from_app;     //giriş arabelleğine karakter ekle
      bytesRecvd++;                                // alınan artımlı bayt (bu işlem bir indeks olarak hareket eder)
      if (bytesRecvd == buffSize) {    // inputBuffer'ın doldurulması durumunda alınan bir güvenlik (bu olmamalıdır)
        bytesRecvd = buffSize - 1;    // eğer bytesReceived > buffer size'dan büyükse, bytesReceived'ı buffer size'dan daha küçük ayarla
      }
    }
  }
}

//8===========================D

void move_servo() {
  
  byte pan_servo_position = map(inputBuffer[0], 0, 253, pan_limit_2, pan_limit_1);//inputbuffer değerini yatay servo pozisyon değerine dönüştür
  pan_servo.write(pan_servo_position); //yatay servo konumunu ayarla
  byte tilt_servo_position = map(inputBuffer[1], 0 , 253, tilt_limit_2, tilt_limit_1); //inputbuffer değerini dikey servo pozisyon değerine dönüştür
  tilt_servo.write(tilt_servo_position); //dikey servo konumunu ayarla
}

//8===========================D

void set_recoil() {

  if (inputBuffer[3] == 1) {        //eğer ateşlemeye basılırsa
    if (!is_firing && !recoiling) { //ve zaten ateş etmiyor veya geri tepmiyorsa
      can_fire = true;              
    }
  }
  else {                  // eğer ateşlemeye basılmazsa
    can_fire = false;     
  }
}

//8===========================D

void set_motor() {
  //-----ırfp250n mosfet kullanarak motorları çalıştırma ve durdurma

  if (inputBuffer[2] == 1) {                //ekrana dokunulursa
    digitalWrite(motor_pin, HIGH);          //motoru aç
    motors_ON = true;
  }
  else {                                   //ekrana dokunulmazsa
    digitalWrite(motor_pin, LOW);          //motoru kapat
    motors_ON = false;

  }
}

//8===========================D

void fire() { //motor baytı açıksa, motoru aç ve açık kaldığını kontrol et

  if (can_fire && !is_firing && motors_ON) {
    //if (can_fire && !is_firing) {
    firing_start_time = millis();
    recoil_start_time = millis();
    is_firing = true;
  }

  firing_current_time = millis();
  recoil_current_time = millis();

  if (is_firing && firing_current_time - firing_start_time < firing_time) {
    recoil_servo.write(recoil_pushed);
  }
  else if (is_firing && recoil_current_time - recoil_start_time < recoil_time) {
    recoil_servo.write(recoil_rest);
  }
  else if (is_firing && recoil_current_time - recoil_start_time > recoil_time) {
    is_firing = false;
  }

}
