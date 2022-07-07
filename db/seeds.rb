# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

c1 = Category.create! name: 'Кузовные работы'
c2 = Category.create! name: 'Работы по двигателю'
c3 = Category.create! name: 'Электрика'

c1.services.create! name: 'Замена одного элемента', price: 7000.00
c1.services.create! name: 'Выравнивание вмятины', price: 2000.00
c1.services.create! name: 'Покраска одного элемента', price: 5000.00

c2.services.create! name: 'Проточка цилиндров', price: 15_000.00
c2.services.create! name: 'Замена ремня ГРМ', price: 4000.00
c2.services.create! name: 'Замена свечей', price: 2000.00

c3.services.create! name: 'Замена проводки', price: 20_000.00
c3.services.create! name: 'Установка сигнализации', price: 10_000.00
c3.services.create! name: 'Установка камеры заднего вида', price: 12_000.00

User.create! name: 'Вася Васечкин'
User.create! name: 'Петя Петичкин'
User.create! name: 'Ваня Ванечкин'
