# Generated by Django 5.1.3 on 2024-11-13 13:09

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='CustomTask',
            fields=[
                ('task_id', models.AutoField(primary_key=True, serialize=False)),
                ('task_name', models.CharField(max_length=255)),
                ('task_desc', models.TextField()),
                ('scheduled_date', models.DateField()),
                ('scheduled_start_time', models.TimeField()),
                ('scheduled_end_time', models.TimeField()),
                ('priority', models.IntegerField()),
                ('deadline', models.DateTimeField()),
                ('status', models.CharField(max_length=50)),
                ('subject_code', models.CharField(max_length=50)),
                ('student', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='tasks', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
