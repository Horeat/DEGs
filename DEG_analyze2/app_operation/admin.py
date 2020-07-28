from django.contrib import admin

# Register your models here.

from .models import UserHistory
from .models import UserMessage

class UserHistoryAdmin(admin.ModelAdmin):
    list_display = ['user_id','upload_file','method_id','args_choose','result_file','use_time']
    search_fields = ['user_id','method_id']
    list_filter = ['user_id','upload_file','method_id','args_choose','result_file','use_time']

class UserMessageAdmin(admin.ModelAdmin):
    list_display = ['user','message','has_read','add_time']
    search_fields = ['user']
    list_filter = ['user','message','has_read','add_time']

admin.site.register(UserHistory,UserHistoryAdmin)
admin.site.register(UserMessage,UserMessageAdmin)