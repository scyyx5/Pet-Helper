# Generated by Django 4.0.3 on 2022-03-11 12:21

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0028_pet_pet_birth'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='pet',
            name='pet_birth',
        ),
    ]
