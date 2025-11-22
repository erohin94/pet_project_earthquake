## Начальные настройки - создание проекта

Создаем папку с проектом на гитхабе. 

Добавил питоновский gitignore и MIT лицензию.

<img width="882" height="789" alt="image" src="https://github.com/user-attachments/assets/a90678fa-88cc-4105-ae90-f6417be3525a" />

Создаю локальную папку на своем компьютере, например `C:\Users\erohi\Desktop\de_project`

Открываю терминал и перехожу в папку `cd C:\Users\erohi\Desktop\de_project`

Клонирую репозиторий `git clone git@github.com:erohin94/pet_project_earthquake.git`

<img width="1237" height="546" alt="image" src="https://github.com/user-attachments/assets/500dd782-ab81-4b35-9b6b-e4dc7cf02b85" />

<img width="763" height="147" alt="image" src="https://github.com/user-attachments/assets/30ff7da1-1f9b-4986-9f20-86327b918f0d" />

Видим как удаленныйрепозиторий склонировался в локальную папку.

<img width="621" height="154" alt="image" src="https://github.com/user-attachments/assets/c99a0e74-63de-4994-ba95-3ffe80795ded" />

## Проверяю работоспособность локального и удаленного репозитория.

Проверяю версию git `git --version`

<img width="386" height="32" alt="image" src="https://github.com/user-attachments/assets/00827df4-81f2-43e4-bbb3-927eba29df32" />

Задаю имя пользлвателя и почту, далее делаю проверку

```
git config --global user.name "Ваше имя"
git config --global user.email "email@domain.com"

git config user.email
git config user.name
```

<img width="686" height="147" alt="image" src="https://github.com/user-attachments/assets/4d228749-c507-49b3-8577-66253c14aadd" />

Создаю локально тестовый файл `test_file.txt`

<img width="622" height="194" alt="image" src="https://github.com/user-attachments/assets/18dfb0b7-1585-4962-a24c-7dc0822c5f35" />

Пробую его отправить в удаленный репозиторий, но перед отправкой, если в удаленном репозитории были какие либо изменения, их надо сначала добавить в локальный.

Сначала подтягиваем изменения с удалённого репозитория: `git pull origin main`

<img width="700" height="213" alt="image" src="https://github.com/user-attachments/assets/ffc16e18-8199-4317-85a8-18617b338261" />

Добавить файлы: `git add .`

Сделать коммит: `git commit -m "Тестовый коммит"`

<img width="737" height="101" alt="image" src="https://github.com/user-attachments/assets/c3c46477-aa5b-43da-9974-e1c46a848d0d" />

Затем пушим: `git push origin main`

<img width="617" height="165" alt="image" src="https://github.com/user-attachments/assets/a6e44861-6c3b-40de-b3b0-f2eafbeda88b" />

Как видим, файл добавлен в удаленный репозиторий.

<img width="1309" height="396" alt="image" src="https://github.com/user-attachments/assets/6776b1a3-feeb-4a0c-9d96-140827d946a6" />

## Создание виртуального окружения

Открываю VS Code и создаю виртуальное окружение: `python -m venv venv`

Активирую виртуальное окружение: `venv\Scripts\activate`

<img width="851" height="181" alt="image" src="https://github.com/user-attachments/assets/96c9049f-54cf-45c4-9f53-ef8511eac1e9" />

Как видно, на текущий момент абсолютно пустое виртуальное окружение

<img width="578" height="88" alt="image" src="https://github.com/user-attachments/assets/e66c1507-8288-405d-a62d-294075f94a8c" />

## Разворачивание инфраструктуры

