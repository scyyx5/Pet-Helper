from operator import mod
from django.db import models
from django.utils import timezone
#from django.contrib.auth.models import User
from django.dispatch import receiver
from django.db.models.signals import post_save
#Override the default user model
from django.contrib.auth.models import User


class PetOwner2(models.Model):
    # 定义一个一对一的外键
    user = models.OneToOneField(User,on_delete=models.CASCADE,primary_key=True,related_name='user')
    FONT_SIZE = (('s', 'small'), ('m', 'medium'), ('l', 'large'))
    MODE = (('1', '1'), ('0', '0'))
    STATUS = (('1', '1'), ('0', '0'))
    FILTER = (('None', 'None'), ('Protanopia', 'Protanopia'), ('Protanomaly', 'Protanomaly'), ('Deuteranopia', 'Deuteranopia'), ('Deuteranomaly', 'Deuteranomaly'),('Tritanopia', 'Tritanopia'),('Tritanomaly', 'Tritanomaly'),('Achromatopsia', 'Achromatopsia'))
    ally_textSize = models.CharField(max_length=3, default='m',null=False, choices=FONT_SIZE)
    ally_darkMode = models.CharField(max_length=1, default='0',null=False, choices=MODE)
    ally_colourBlind = models.CharField(max_length=200, default='None',null=False, choices=FILTER)
    reminder_walk = models.CharField(default='0', choices=STATUS, max_length=200, null=False)
    reminder_feed = models.CharField(default='0', choices=STATUS, max_length=200, null=False)
    ally_contrastMode = models.CharField(max_length=1, default='0',null=False, choices=MODE)
    def __str__(self):
        return self.user.first_name + ' ' + self.user.last_name

    # 这是一个信号函数，即每创建一个User对象时，就会新建一个userextionsion进行绑定，使用了receiver这个装饰器
    @receiver(post_save,sender=User)
    def handler_user_extension(sender,instance,created,**kwargs):
        if created:  # 如果是第一次创建user对象，就创建一个userextension对象进行绑定
            PetOwner2.objects.create(user=instance)
        else:  # 如果是修改user对象，那么也要将petowner进行保存
            instance.user.save()



# change to Pet Owner
class PetOwner(models.Model):
    FONT_SIZE = (('s', 'small'), ('m', 'medium'),('l', 'large'))
    MODE = (('1', '1'), ('0', '0'))
    STATUS = (('1', '1'), ('0', '0'))
    FILTER = (('None', 'None'), ('Protanopia', 'Protanopia'),
              ('Protanomaly', 'Protanomaly'),('Deuteranopia', 'Deuteranopia'),('Deuteranomaly', 'Deuteranomaly'),
              ('Tritanopia', 'Tritanopia'),('Tritanomaly', 'Tritanomaly'),('Achromatopsia', 'Achromatopsia'))
    user_fname = models.CharField(max_length=100, default='NA')
    user_lname = models.CharField(max_length=100, default='NA')
    user_email = models.CharField(max_length=100, default='NA')
    user_password = models.CharField(max_length=100, default='NA')
    ally_textSize= models.CharField(max_length=3, default='m',null=False, choices=FONT_SIZE)
    ally_darkMode= models.CharField(max_length=1, default='0',null=False, choices=MODE)
    ally_colourBlind= models.CharField(max_length=200, default='None',null=False, choices=FILTER)
    reminder_walk = models.CharField(default='0', choices=STATUS, max_length=200, null=False)
    reminder_feed = models.CharField(default='0', choices=STATUS, max_length=200, null=False)
    def __str__(self):
        return self.user_fname


class Pet(models.Model):
    TYPE = (('Cat', 'Cat'), ('Dog', 'Dog'))
    SEX = (('F', 'Female'), ('M', 'Male'))
    pet_name = models.CharField(max_length=300, default='NA')
    pet_sex = models.CharField(default='Male',max_length=300, null=False, choices=SEX)
    pet_type = models.CharField(default='NA', max_length=300, null=False, choices=TYPE)
    pet_birth = models.DateField(default=timezone.now, blank=False, null=False, )
    pet_weight = models.CharField(max_length=300, default='NA')
    user = models.ForeignKey(User, null=False, on_delete=models.SET(1),default=1)
    pet_pic = models.ImageField(null=True, blank=True, upload_to='images/')
    def __str__(self):
        return self.pet_name


# add Calenda
# r class
class Calendar(models.Model):
    STATUS = (('Done','Done') , ('Not Done' , 'Not Done'))
    # id = models.AutoField(primary_key=True)
    pet = models.ForeignKey(Pet,null=True,on_delete=models.SET_NULL)
    date = models.DateField(default=timezone.now, blank=False, null=False)
    title = models.CharField(max_length=100,default='NA')
    user = models.ForeignKey(User, null=False, on_delete=models.SET(1),default=1)
    isChecked = models.CharField(default='Not Done',max_length=200, null=True,choices=STATUS)
    def __str__(self):
        return self.pet.pet_name+': '+self.title

class Command(models.Model):
    title = models.CharField(max_length=64)
    teach = models.TextField(default='NA')
    audio = models.FileField(default='NA')
    def __str__(self):
        return self.title

class Information(models.Model):
    TYPE = (('Cat', 'Cat'), ('Dog', 'Dog'))
    title = models.TextField()
    article = models.TextField()
    category = models.CharField(default='Dog',max_length=200, null=False, choices=TYPE)
    heroid = models.CharField(max_length=100, default='Article')
    article_image = models.ImageField(null=True, blank=True, upload_to='info_images/')
    def __str__(self):
        return self.title


class Feedback(models.Model):
     feedback = models.TextField()


class Image(models.Model):
     Image = models.ImageField(null=True, blank=True, upload_to='images/')
     # title = models.TextField(default='NA')

