# Generated by Django 3.2.12 on 2022-03-17 22:25

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0063_information_article_image'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='calender',
            name='task_date',
        ),
    ]
