# Домашнее задание к занятию 7 «Жизненный цикл ПО»

## Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:

    1) Open -> On reproduce.
    2) On reproduce -> Open, Done reproduce.
    3) Done reproduce -> On fix.
    4) On fix -> On reproduce, Done fix.
    5) Done fix -> On test.
    6) On test -> On fix, Done.
    7) Done -> Closed, Open.
<p align="center">
  <img src='https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/09-ci-01-intro/Bug.png' width='850'>
</p>

## Остальные задачи должны проходить по упрощённому workflow:

    1) Open -> On develop.
    2) On develop -> Open, Done develop.
    3) Done develop -> On test.
    4) On test -> On develop, Done.
    5) Done -> Closed, Open.
<p align="center">
  <img src='https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/09-ci-01-intro/Other_tasks.png' width='750'>
</p>
