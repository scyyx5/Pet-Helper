# Generated by Django 4.0.3 on 2022-03-13 13:00

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0045_alter_information_article_image'),
    ]

    operations = [
        migrations.AddField(
            model_name='information',
            name='heroid',
            field=models.CharField(default='Article', max_length=100),
        ),
    ]
