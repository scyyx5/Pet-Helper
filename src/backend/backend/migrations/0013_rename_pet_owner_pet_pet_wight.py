# Generated by Django 4.0.2 on 2022-03-05 13:42
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0012_alter_petuser_user_email'),
    ]

    operations = [
        migrations.RenameField(
            model_name='pet',
            old_name='pet_owner',
            new_name='pet_wight',
        ),
    ]
