# Generated by Django 4.0.3 on 2022-03-11 12:13

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0026_rename_information_artical_information_artical_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='pet',
            name='pet_age',
        ),
    ]
