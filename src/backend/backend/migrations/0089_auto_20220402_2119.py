# Generated by Django 3.2.12 on 2022-04-02 20:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0088_auto_20220402_2118'),
    ]

    operations = [
        migrations.AlterField(
            model_name='calendar',
            name='pet_owner',
            field=models.ForeignKey(default=1, on_delete=models.SET(1), to='backend.petowner'),
        ),
        migrations.AlterField(
            model_name='pet',
            name='pet_owner',
            field=models.ForeignKey(default=1, on_delete=models.SET(1), to='backend.petowner'),
        ),
    ]
