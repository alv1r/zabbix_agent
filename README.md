

# zabbix_agent
Installation script for Zabbix agent (Windows 32/64)

Скрипт для установки Zabbix агента.

Основыные функции:
 
 ⋅ Определение разрядности ОС и установка подходящей версии агента.
 
 ⋅ Получение адреса сервера из строки запуска
 
 ⋅ Создание конфигурационного файла на основе настроек скрипта
 
 ⋅ Определение имени хоста для [активных проверок](https://www.zabbix.com/documentation/current/ru/manual/appendix/items/activepassive).
 
 ⋅ Создание правил файерволла.

# Установка

Распакуйте архив в папку zabbix_agent. 
Cкачайте Zabbix Agent LTS (нам нужны архивы для обеих разрядностией) [отсюда](https://www.zabbix.com/download_agents).

Структура каталогов должна быть такой:  

     zabbix_agent
     
     |_bin
     
     |_conf
     

 В корень положите скрипт.
 
  Установка:

      !install.cmd zabbix_server

 Где zabbix_server - IP или FQDN адрес вашего сервера Zabbix
 Запускать от учетной записи с **административными правами**
