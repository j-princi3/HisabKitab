# Generated by Django 5.0.2 on 2024-03-15 09:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('hisab', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='MyModel',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('description', models.TextField()),
            ],
        ),
    ]
