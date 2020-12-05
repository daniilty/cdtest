# CD test

## Подготовлено Тураевым Даниилом(daniilty)

## 1.0 Введение

Тестирование проводилось над коммандой `cd` в стандартном коммандном интерпретаторе **Windows 10**. Данная комманда позволяет пользователю менять директории.

## 2.0 Цели и задачи

### 2.1 Цели

**Цели:** Предложить структуру каталогов и реализовать автоматическое выполнение тестового сценария.

### 2.2 Задачи

**Задачи:** Составить тест-план, написать Unit тесты и провести стресс-тест.

## 3.0 Стратегия тестирования

Для начала сымитируем действия пользователя и попробуем зайти в какую-нибудь папку. При успешном выполнении выведем "All fine". Если пользователь захочет зайти в несуществующую папку, поднимем исключение.

## 3.1 Unit тестирование

Так как данный сценарий не требует интеграционных тестов, напишем три юнит теста с помощью гема `rspec`.

*Код тестового модуля:*

```ruby
module Basic

  def Basic.cd_into(dir="")
    status = system("cd", dir)
    if status
      puts "all fine"
    else
      raise Exception.new "This dir is nonexistent"
    end
  end

  def Basic.make_dir_and_cd(dir)
      status = system("mkdir", dir)
      if status
        system("cd", dir)
        puts "everything is still fine"
        system("rmdir", dir)
      end
  end
end
```
Первый метод данного модуля запускает комманду из стандартного системного коммандного интерпретатора и поднимает ошибку, если пользователь решит зайти в несуществующую папку. Второй же создан для создания и входа в свежую директорию.

**Первый сценарий:** Пользователь пытается зайти в существующую папку:
```ruby
it "cd`s into an existing path" do
  expect{Basic.cd_into("lib")}.to output("all fine\n").to_stdout
end
```
У него все удачно выходит и он получает доступ к заветной директории. Программа выводит "All fine".

**Второй сценарий:** Пользователь заходит в несуществующую папку и получает исключение:
```ruby
it "cd's into an unexistent path" do
  expect{Basic.cd_into("kk")}.to raise_error
end
```

**Третий сценарий:** Пользователь заходит в несуществующую папку и создает новую:
```ruby
it "cd's into an unexistent path and making a new one" do
  expect{Basic.make_dir_and_cd("kk")}.to output("everything is still fine\n").to_stdout
end
```
## 3.2 Стресс-тест
ОС: Windows 10 Pro 2004
CPU: Ryzen 2600
Ram: 16Gb

Протестируем исполнение под нагрузкой(1000 открытий одной папки):
```ruby
it "it doing good under the stress" do
  puts Benchmark.measure {
    1000.times do
      Basic.cd_into("lib")
    end
  }
end
```
```
Finished in 7.65 seconds (files took 0.20307 seconds to load)
4 examples, 0 failures
```
Результаты довольно неплохие.

## 4.0 Требования к окружению

ОС: Windows 10
Ruby: 2.6+
Bundler: 1.17.2

## 5.0 Зависимости

```ruby
gem 'rspec'
gem 'benchmark'
```

## 6.0 Инструмент тестирования

Основным инструментом автоматизированного тестирования является RSpec.

## 7.0 Инструкция для локального запуска:
```
$ git clone https://github.com/daniilty/cdtest.git
$ cd cdtest
$ gem install bundler -v 1.17.2
$ bundle install
$ bundle exec rspec
```
