# Generated by Django 5.0.2 on 2024-04-10 04:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('hisab', '0008_alter_bankbalance_time_alter_count_time_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='count',
            name='notes_100',
            field=models.IntegerField(),
        ),
        migrations.AlterField(
            model_name='count',
            name='notes_200',
            field=models.IntegerField(),
        ),
        migrations.AlterField(
            model_name='count',
            name='notes_500',
            field=models.IntegerField(),
        ),
        migrations.AlterField(
            model_name='extraexpense',
            name='notes_100',
            field=models.IntegerField(),
        ),
        migrations.AlterField(
            model_name='extraexpense',
            name='notes_200',
            field=models.IntegerField(),
        ),
        migrations.AlterField(
            model_name='extraexpense',
            name='notes_500',
            field=models.IntegerField(),
        ),
    ]