



Фреймворки и библиотеки для кроссплатформенной разработки
=============================================================================

* [Кроссплатформенная разработка десктопных программ и компилируемые ЯП](#кроссплатформенная-разработка-десктопных-программ) 10 баллов

* [Использование веб-технологий для кроссплатформенной разработки и Скриптовые ЯП](#использование-веб-технологий-для-кроссплатформен-ной-разработки) 10 баллов

* [Кроссплатформенная разработка мобильных программ](#кроссплатформенная-разработка-мобильных-программ) 12 баллов

_______________
<img width="1023" alt="Снимок экрана 2024-09-03 в 13 05 50" src="https://github.com/user-attachments/assets/98ffbc5e-5667-4b87-88a3-94c2630da208">

<img width="1300" alt="NAzarova" src="https://github.com/user-attachments/assets/a59605da-3b93-4ce9-b892-5880afb68476">


В этой статье я расскажу вам о некоторых самых популярных фреймворках, которые помогут вам при разработке программ для компьютеров под управлением Windows/MacOS/Linux. Если вы опытный программист, то вряд ли найдете в этой статье что-то новое для себя. Она скорее для новичков, которые ищут простое решение своей проблемы — быстрое написание хорошей (на сколько это возможно) кроссплатформенной программы.

![](https://habrastorage.org/r/w780q1/getpro/habr/upload_files/ef3/02f/a2f/ef302fa2f829c8671acceba5bfbb23c4.jpeg)

### Что такое кроссплатформенная разработка?

Что вообще из себя представляет кроссплатформенная разработка? Если вам нужно, чтобы ваше приложение работало сразу на нескольких операционных системах с минимальными затратами человеко-ресурса, то скорее всего вы прибегнете именно к этому. Вы разрабатываете одну программу, пишете один код, а он запускается на всех поддерживаемых платформах. Удобно! Но стоит различать кроссплатформенность и нативность.

Если вкратце, то кроссплатформенность — это способность программного обеспечения работать с несколькими аппаратными платформами или операционными системами. Нативные программы в свою очередь пишутся для работы на определенной аппаратной или программной платформе. Из этого можно сделать вывод: если ваша программа будет работать с железом, то скорее всего даже в кроссплатформенной программе вам придется прописывать нативный функционал для конкретной платформы.

В чем же преимущество кроссплатформенной разработки? Во-первых, вам нужно задействовать меньше людей (не нужно содержать DotNet разработчика, Swift/objective C разработчика и всех к ним прилагающихся), во вторых вы охватываете большее количество устройств -> больше людей смогут пользоваться вашей программой.

Также подобный принцип не лишен недостатков — плохая нативность, оптимизация тоже будет хуже, чем у такой же программы написанной под конкретную платформу. Но иногда бывает такое, что вам очень нужно, чтобы ваше приложение поддерживало несколько платформ, но разрабатывать под каждую возможности нет. Тогда на помощь приходят уже созданные Фреймворки и технологии для разработки кроссплатформенных GUI. Вот некоторые из них:

# Кроссплатформенная разработка десктопных программ

### Qt/QML

![](https://habrastorage.org/r/w1560/getpro/habr/upload_files/4f2/6ff/712/4f26ff7121317872bda7711cc91380d6.png)

Qt — очень мощный набор инструментов для создания кроссплатформенных приложений на языке С++ и Python (а также Ruby, PHP, C# и др. но они в отличии поддерживаются сообществом). Qt уже достаточно старый фреймворк, но он продолжает активно развиваться и на нем написаны такие программы как: 2ГИС для Android, Kaspersky Internet Security, Virtual Box, Skype, VLC Media Player, Opera и другие. Известное многим линукс-юзерам окружение рабочего стола KDE тоже написано с использованием Qt. Qt имеет среду разработки — Qt Creator, которая включает в себя Qt Designer с помощью которого можно создавать графический интерфейс. Визуальное создание интерфейса позволяет легко и просто создавать интерфейс, перетаскивая различные виджеты (выпадающие списки, кнопки, переключатели) на форму. Qt имеет обширную документацию, активную поддержку сообщества и множество других преимуществ.

[Официальный сайт](https://www.qt.io/)

**Плюсы**

*   Визуальный редактор интерфейса
    
*   Огромное количество модулей в составе фреймворка
    
*   Поддержка большого количества языков программирования (официально только Python и C++, остальные поддерживаются сообществом) -> хорошая нативность при грамотном коде
    
*   Низкий порог вхождения
    

**Минусы**

*   Большой вес приложения
    
*   Высокая стоимость коммерческой лицензии
    

### GTK

![](https://habrastorage.org/r/w1560/getpro/habr/upload_files/edc/c24/45e/edcc2445e552295666d6b3c8bf1eb01f.png)

GTK на ряду с Qt является одной из самых популярных библиотек для кроссплатформенной разработки элементов интерфейса для X Window Systems. Разработан Gnome Foundation и GNU. С использованием этой библиотеки написаны многие окружения рабочего стола и оконные менеджеры (Gnome, xfce MATE, Cinnamon, AfterStep, Marco и многие другие), и программы, например: Chromium, FireFox, MonoDevelop, Gimp и другие. GTK написан на языке C, но существуют обертки для многих языков программирование (C, C++, Python, Java и другие). Gtk имеет конструктор для визуальной разработки интерфейсов - Glade

[Официальный сайт](https://www.gtk.org)

#### Плюсы

*   Поддержка большого количества языков
    
*   Большое и активное сообщество
    
*   Много популярных проектов и примеров
    
*   Визуальный редактор
    

#### Минусы

*   Критичных минусов обнаружено не было (если у вас есть "проблемы" с Gtk - можете написать об этом в комментарии)
    

* * *

### WxWidgets/WxPython

![](https://habrastorage.org/r/w1560/getpro/habr/upload_files/b0b/8ef/890/b0b8ef890cc587d8da52c0bea40f405f.png)

**wxWidgets** (ранее известная как **wxWindows**) — это кросс-платформенная библиотека инструментов с открытым исходным кодом для разработки кроссплатформенных на уровне исходного кода приложений, в частности для построения графического интерфейса пользователя (GUI).Она разработана не только для того, чтобы создавать GUI. Она также имеет набор классов для работы с графическими изображениями, HTML, XML документами, архивами, файловыми системами, процессами, подсистемами печати, мультимедиа, сетями, классы для организации многопоточности, отладки, отправки дампов и множество других инструментов. Имеет обертку для языка Python -WxPython. С использованием этой библиотеки написанны такие программы как: FileZilla, AudaCity, BitTorrent и другие.

[Официальный сайт](https://www.wxwidgets.org/)

**Минусы**

*   Мало современной информации в интернете
    
*   Не очень активное сообщество
    

**Плюсы**

*   Простое написание интерфесов
    
*   поддержка разных языков программирования
    

* * *

### Tkinter

![](https://habrastorage.org/r/w780q1/getpro/habr/upload_files/6ca/069/ad2/6ca069ad257a2f7a59066487d72425df.jpg)

Tkinter - кросс-платформенная событийно-ориентированная графическая библиотека разработанная Гвидо ван Россумом (создатель языка Python), позволяет написать вам простой, но функциональный интерфейс для вашего проекта на Python. По сути Tkinter представляет из себя пакет для Python, предназначенный для работы с библиотекой Tk. Библиотека Tk содержит компоненты графического интерфейса пользователя (graphical user interface – GUI), написанные на языке программирования Tcl и существуют реализации для разных языков (Tkinter приведен для примера).

Официальный сайт

**Минусы**

*   Примитивные интерфейсы
    
*   Для одного языка (но непосредственно Tk существует для разных языков)
    

**Плюсы**

*   Простое написание интерфесов
    
*   Позволяет вам быстро написать простой GUI для вашей Python программы
    

* * *

# Использование веб-технологий для кроссплатформен ной разработки

### Electron JS

![](https://habrastorage.org/r/w1560/getpro/habr/upload_files/de3/d4d/bdf/de3d4dbdf61a14d77ab3804441126064.png)

Недавно я написал статью о том, как на Electron JS написать "Hello World". В комментариях поднялась дискуссия о "за и против" этой технологии. До сих пор очень многие разработчики ведут споры относительно того, стоит ли использовать Electron в своих проектах или нет. Electron JS — это JavaScript фреймворк, позволяющий вам написать полноценную программу используя Web Технологии — HTML & CSS, JS. Electron JS представляет собой движок Chromium в котором и исполняется весь ваш код. У Electron'a есть один, но достаточно серьезный недостаток — большое потребление памяти, как физической, так и оперативной. Всем давно известно, какой прожорливый Chrome, а мы на него еще своего кода хотим навесить. Но если посмотреть с другой стороны: сегодня многие популярные приложения написаны на Electron'e — Slack, Skype, Discord, VSCode, Atom, Postman, Insomnia и т.д. А с учетом непрекращающегося роста мощности компьютеров все реже приходится слышать от пользователей, что «ваш хром съел всю мою память». Высокое потребление памяти не будет играть большой роли если продукт будет хорош в своей сфере, будет грамотно написан код и распределены процессы

[Официальный сайт](https://www.electronjs.org/)

**Плюсы**

*   Использование наработок из Web
    
*   Просто найти (или "воспитать") специалиста
    
*   Качественная (и русифицированная) документация
    
*   Поддержка сообщества и GitHub
    

**Минусы**

*   Высокое потребление памяти (физическая и ОЗУ)
    
*   Легко написать плохой код
    
*   Плохая нативность
    

* * *

### NW.JS

![](https://habrastorage.org/r/w1560/getpro/habr/upload_files/23f/948/7b8/23f9487b87c53a062bc6f1d77683380a.png)

Так же как и Electron, NW.JS позволяет вам создавать кроссплатформенные приложения с использованием Web технологий. Сегодня NW.JS Спонсируется компанией Intel, и разрабатывается сообществом. NW.JS не может похвастаться таким же богатым списком проектов как Electron, но это все равно очень хороший фреймворк для создания кроссплатформенных приложений. Так же как и Electron, NW.JS тащит за собой движок Chromium и все вытекающие из него проблемы. NW.JS очень похож по своему принципу на Electron, но все-же различия есть. Могу порекомендовать вам [эту статью](https://habr.com/ru/post/304574/) для ознакомления.

**Плюсы**

*   Использование наработок из Web
    
*   Просто найти (или "воспитать") специалиста
    
*   Качественная (и русифицированная) документация
    
*   Поддержка сообщества и GitHub
    

**Минусы**

*   Высокое потребление памяти (физическая и ОЗУ)
    
*   Легко написать плохой код
    
*   Плохая нативность
    

* * *


### Avalonia

![](https://habrastorage.org/r/w1560/getpro/habr/upload_files/0c5/ae8/356/0c5ae83568931ce09a97f84f33bc8f18.png)

Достаточно молодой и активно развивающийся фреймворк для кроссплатформенной разработки, разработанный [Стивеном Кирком](https://github.com/grokys) и поддерживаемый [.NET Foundation](https://dotnetfoundation.org/) и сообществом. Avalonia позволяет создавать интерфейсы на основе XAML. Сама Avalonia основана на WPF/UWP. Код пишется на языке C#. Благодаря XAML Avalonia позволяет создавать гибкие и стилизованные интерфейсы. Имеет хорошую документацию, хоть и не большое, но очень приветливое рускоязычное сообщество.

[Официальный сайт](https://avaloniaui.net/)

**Плюсы**

*   Хорошая нативность (+поддержка системных декораций)
    
*   Активное и приветливое сообщество, как русскоязычное, так и англоязычное (чаты, форумы)
    
*   Заимствование и сходство с WPF (Если вы работали с WPF вам будет легко разобраться с Авалонией, и при возникновении трудностей, код написанный для WPF скорее всего заработает у вас на авалонии)
    
*   Стили (стили в Авалонии имеют сходство с CSS, что упрощает написание этих самых стилей)
    

**Минусы**

*   Маленькое сообщество (хоть и приветливое, но в силу молодости проекта, еще очень немногочисленное сообщество разработчиков)
    
*   Маленькое количество проектов (вы можете застрять с тем, что никто не решал такую задачу, которая встала перед вами)
    

* * *



# Кроссплатформенная разработка мобильных программ
---

Apache Cordova, Ionic.

1.  Flutter: Flutter - фреймворк для разработки кроссплатформенных мобильных и десктопных приложений на Dart. Он использует свой собственный виджетный движок и поддерживает Windows, macOS, Linux, Android, iOS и веб.

1.  React Native: React Native - это фреймворк для разработки кроссплатформенных мобильных и десктопных приложений на JavaScript и React. Он использует нативные компоненты для создания пользовательского интерфейса и поддерживает Windows, macOS и Linux.

---

# Дополнительно

1.  JavaFX: JavaFX - фреймворк для разработки кроссплатформенных десктопных приложений на Java. Он включает в себя графический интерфейс пользователя, анимацию, мультимедиа и поддержку многопоточности.
    
2.  Xamarin: Xamarin - фреймворк для разработки кроссплатформенных десктопных приложений на С# и .NET. Он позволяет создавать приложения, которые работают на Windows, macOS и Linux.
    
3.  NativeScript: NativeScript - фреймворк для разработки кроссплатформенных мобильных и десктопных приложений на JavaScript, TypeScript и Angular. Он использует нативные компоненты для создания пользовательского интерфейса и поддерживает Windows, macOS и Linux.
    
4.  OpenFL: OpenFL - кроссплатформенная библиотека для разработки игр и приложений на ActionScript и Haxe. Она поддерживает Windows, macOS, Linux, Android и iOS.
    

    

    
