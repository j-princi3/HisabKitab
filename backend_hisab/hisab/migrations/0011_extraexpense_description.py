# Generated by Django 5.0.2 on 2024-05-12 11:57

import django.utils.timezone
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('hisab', '0010_count_total_sales'),
    ]

    operations = [
        migrations.AddField(
            model_name='extraexpense',
            name='description',
            field=models.CharField(default=django.utils.timezone.now, max_length=100),
            preserve_default=False,
        ),
    ]
