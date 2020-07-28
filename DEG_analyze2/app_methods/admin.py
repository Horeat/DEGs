from django.contrib import admin

# Register your models here.

from .models import MethodsInfo

class MethodsInfoAdmin(admin.ModelAdmin):
    list_display = ['method_id','method_name','method_type','method_detail','author','args','use_number']
    search_fields = ['method_id','method_name','method_type','author','use_number']
    list_filter = ['method_id','method_name','method_type','method_detail','author','args','use_number']

admin.site.register(MethodsInfo,MethodsInfoAdmin)
