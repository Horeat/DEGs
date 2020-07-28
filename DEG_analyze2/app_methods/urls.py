# -*- coding: utf-8 -*-

from django.conf.urls import url, include

from .views import MethodListView, MethodDetailView


urlpatterns = [
    #方法列表页
    url(r'^list/$', MethodListView.as_view(), name="methods_list"),

    #方法详情页
    url(r'^detail/(?P<method_id>\d+)/$', MethodDetailView.as_view(), name="method_detail"),
]