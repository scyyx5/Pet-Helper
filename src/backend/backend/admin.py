from django.contrib import admin
from .models import *
from django.contrib.auth.models import User

admin.site.register(PetOwner2)
admin.site.register(PetOwner)
admin.site.register(Pet)
admin.site.register(Calendar)
admin.site.register(Command)
admin.site.register(Information)
admin.site.register(Feedback)
admin.site.register(Image)

