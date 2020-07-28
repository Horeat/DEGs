"""DEG_analyze2 URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.conf.urls import url, include
from django.views.generic import TemplateView
from django.views.static import serve
# import xadmin

from app_users.views import LoginView, LogoutView, RegisterView, AciveUserView, ForgetPwdView, ResetView, ModifyPwdView
from DEG_analyze2.settings import MEDIA_ROOT, STATIC_ROOT
# from users.views import IndexView

urlpatterns = [
    url(r'admin/', admin.site.urls),
    url('^$', TemplateView.as_view(template_name= "index.html"),name="index"),
    url('^login/$', LoginView.as_view(), name="login"),
    url('^logout/$', LogoutView.as_view(), name="logout"),
    url('^register/$', RegisterView.as_view(), name="register"),
    url(r'^captcha/',include('captcha.urls')),
    url(r'^active/(?P<active_code>.*)/$',AciveUserView.as_view(),name="user_active"),
    url(r'^forget/$', ForgetPwdView.as_view(), name="forget_pwd"),
    url(r'^reset/(?P<active_code>.*)/$',ResetView.as_view(),name="reset_pwd"),
    url(r'^modify_pwd/$', ModifyPwdView.as_view(), name="modify_pwd"),

    #用户相关url配置
    url(r'^users/',include(('app_users.urls', 'app_users'), namespace="users")),

    #方法相关url配置
    url(r'^methods/',include(('app_methods.urls', 'app_methods'), namespace="methods")),

    #操作相关url配置
    url(r'^operation/',include(('app_operation.urls', 'app_operation'), namespace="operation")),

    #DEBGU为FALSE时添加static的路由
    # url(r'^static/(?P<path>.*)$',  serve, {"document_root":STATIC_ROOT}),

    #配置上传文件的访问处理函数
    url(r'^media/(?P<path>.*)$',  serve, {"document_root":MEDIA_ROOT}),
]


#全局404页面配置
handler404 = 'app_users.views.page_not_found'
handler500 = 'app_users.views.page_error'