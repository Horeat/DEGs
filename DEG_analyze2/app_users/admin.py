from django.contrib import admin

# Register your models here.

from .models import UserProfile
from .models import EmailVerifyRecord

class UserProfileAdmin(admin.ModelAdmin):
    list_display = ['nick_name','birday','gender','address','mobile','image']
    search_fields = ['nick_name']
    list_filter = ['nick_name','gender']

class EmailVerifyRecordAdmin(admin.ModelAdmin):
    list_display = ['code','email','send_type','send_time']
    search_fields = ['code','email','send_type']
    list_filter = ['code','email','send_type','send_time']


admin.site.register(UserProfile,UserProfileAdmin)
admin.site.register(EmailVerifyRecord,EmailVerifyRecordAdmin)
