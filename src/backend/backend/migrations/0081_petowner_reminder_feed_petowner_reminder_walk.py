# Generated by Django 4.0.3 on 2022-04-01 16:56

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0080_petowner_alter_pet_pet_birth_alter_pet_pet_owner_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='petowner',
            name='reminder_feed',
            field=models.CharField(choices=[('1', '1'), ('0', '0')], default='0', max_length=200),
        ),
        migrations.AddField(
            model_name='petowner',
            name='reminder_walk',
            field=models.CharField(choices=[('1', '1'), ('0', '0')], default='0', max_length=200),
        ),
    ]
