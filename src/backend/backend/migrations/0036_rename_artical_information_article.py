# Generated by Django 4.0.3 on 2022-03-11 23:14

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0035_reminder_reminder_feed_reminder_reminder_walk'),
    ]

    operations = [
        migrations.RenameField(
            model_name='information',
            old_name='artical',
            new_name='article',
        ),
    ]
