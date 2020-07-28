# Generated by Django 2.2.6 on 2020-02-26 00:31

import datetime
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('app_methods', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='UserMessage',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user', models.IntegerField(default=0, verbose_name='接收用户')),
                ('message', models.CharField(max_length=500, verbose_name='消息内容')),
                ('has_read', models.BooleanField(default=False, verbose_name='是否已读')),
                ('add_time', models.DateTimeField(default=datetime.datetime.now, verbose_name='添加时间')),
            ],
            options={
                'verbose_name': '用户消息',
                'verbose_name_plural': '用户消息',
            },
        ),
        migrations.CreateModel(
            name='UserHistory',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('upload_file', models.FileField(upload_to='uploads/%Y/%m/%d', verbose_name='上传文件')),
                ('args_choose', models.CharField(max_length=50, verbose_name='参数选择')),
                ('result_file', models.FileField(upload_to='result/%Y/%m/%d', verbose_name='筛选结果文件')),
                ('use_time', models.DateTimeField(default=datetime.datetime.now, verbose_name='操作时间')),
                ('method_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app_methods.MethodsInfo', verbose_name='方法编号')),
                ('user_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL, verbose_name='用户名')),
            ],
            options={
                'verbose_name': '用户历史',
                'verbose_name_plural': '用户历史',
            },
        ),
    ]