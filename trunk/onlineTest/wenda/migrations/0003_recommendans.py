# -*- coding: utf-8 -*-
# Generated by Django 1.9.13 on 2019-05-24 14:58
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('wenda', '0002_uploadinfo'),
    ]

    operations = [
        migrations.CreateModel(
            name='RecommendAns',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('qid', models.PositiveIntegerField(verbose_name='问题的id')),
                ('aid', models.PositiveIntegerField(verbose_name='答案的id')),
            ],
        ),
    ]