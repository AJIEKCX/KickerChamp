# Mobile Update

## SwiftUI

### Как перейти с билдов через gradle на xcframework

Для полной интеграции с KMM и реагирования на изменение shared кода проект собирает фреймворк перед каждой сборкой.

Если у вас:

- Нет gradle, java
- Не работает сборка фреймворка

То вам придётся воспользоваться готовым собранным фреймворком под разные архитектуры. Вот как это сделать:

В проекте по пути `iosApp/` лежит файл `shared.xcframework`.

1. Зайти в проект в Target: iosApp
2. На вкладке `General` — `Frameworks, Libraries and Embedded Content` — Добавить `shared.xcframework`
3. На вкладке `Build Settings` — Combined, Levels — найти `Framework Search Paths` и удалить заданное значение.
4. На вкладке `Build Phases` удалить `KMM framework build step`

### Где почитать про SwiftUI

#### Основной контент

- Везде. Из каждого утюга. Или блога.
- Документация Xcode! С проектами-примерами и туториалом.
- WWDC видео про SwiftUI. Много хороших. Apple Developer app поможет.
- [swiftwithmajid](https://swiftwithmajid.com) - блог неплохой, понятно пишет на примерах
- и несколько похожих блогов с начальными темами и быстрыми решениями. Гугли!

На стак оверфлоу могут советовать неправильные подходы, не стоит всему доверять.

#### Продолжение со SwiftUI

- [objc.io](https://objc.io) - книга Thinking in SwiftUI, видео.
- [pointfree.co](https://pointfree.co) - целый UDF фреймворк на Combine

https://twitter.com/agapov_one

[Контур](https://kontur.ru)
