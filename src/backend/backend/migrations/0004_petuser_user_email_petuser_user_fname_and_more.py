# Generated by Django 4.0.2 on 2022-03-01 21:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0003_petuser_delete_user'),
    ]

    operations = [
        migrations.AddField(
            model_name='petuser',
            name='user_email',
            field=models.CharField(default='NA', max_length=100),
        ),
        migrations.AddField(
            model_name='petuser',
            name='user_fname',
            field=models.CharField(default='NA', max_length=100),
        ),
        migrations.AddField(
            model_name='petuser',
            name='user_lname',
            field=models.CharField(default='NA', max_length=100),
        ),
        migrations.AlterField(
            model_name='petuser',
            name='user_phone',
            field=models.CharField(default='NA', max_length=20),
        ),
    ]
