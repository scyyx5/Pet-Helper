#from asyncio.windows_events import NULL
from tkinter.tix import Tree
from rest_framework import viewsets
from . import models
from . import serializers
from rest_framework.response import Response
import requests
from rest_framework.permissions import AllowAny,IsAuthenticated
from rest_framework.authentication import TokenAuthentication


# add viewsets GET Pet and Get Dog cat art
class UserBasedPermission(AllowAny):
    def has_permission(self, request, view):
        for klass, actions in getattr(view, 'action_permissions', {}).items():
            if request.user is not None:
                return klass().has_permission(request, view)
        return False


'''
from rest_framework import permissions

class IsOwnerOfObject(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        print(obj)
        print(request.user)
        return obj == request.user


class CustomerAccessPermission(permissions.BasePermission):
    message = 'Adding customers not allowed.'
    def has_permission(self, request, view):
        if request.user is not NULL:
            return True
        return False
'''


class PetUsersViewset(viewsets.ModelViewSet):
    queryset = models.User.objects.all()
    serializer_class = serializers.PetUser2Serializer
    

class PetOwnersViewset(viewsets.ModelViewSet):
    queryset = models.PetOwner.objects.all()
    serializer_class = serializers.PetOwner2Serializer


class PetOwner2sViewset(viewsets.ModelViewSet):
    queryset = models.PetOwner2.objects.all()
    serializer_class = serializers.PetOwner2Serializer
    permission_classes = (UserBasedPermission,)
    action_permissions = {
        IsAuthenticated: ['GET', 'POST', 'CREATE', 'DELETE', 'PUT'],
        #AllowAny: ['retrieve']
    }
    def get_queryset(self):
        return self.queryset.filter(user_id=self.request.user.id)


class PetOwner2sViewset1(viewsets.ModelViewSet):
    queryset = models.PetOwner2.objects.all()
    serializer_class = serializers.PetOwner2Serializer


class PetViewset(viewsets.ModelViewSet):
    queryset = models.Pet.objects.all()
    serializer_class = serializers.PetSerializer
    permission_classes = (UserBasedPermission,)
    action_permissions = {
        IsAuthenticated: ['GET', 'POST', 'CREATE','DELETE','PUT'],
        #AllowAny: ['retrieve']
    }
    def get_queryset(self):
        return self.queryset.filter(user_id=self.request.user.id)

    authentication_classes = (TokenAuthentication,)

    def create(self, request):
        serializer = serializers.PetSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            requests.post("http://pethelper.bham.team:4444/sendimage/", json=serializer.data)
            return Response(serializer.data)


class CalendarViewset(viewsets.ModelViewSet):
    queryset = models.Calendar.objects.all()
    serializer_class = serializers.CalendarSerializer
    
    permission_classes = (UserBasedPermission,)
    action_permissions = {
        IsAuthenticated: ['GET', 'POST', 'CREATE','DELETE','PUT'],
        # AllowAny: ['retrieve']
    }
    def get_queryset(self):
        return self.queryset.filter(user_id=self.request.user.id)
    authentication_classes = (TokenAuthentication,)
    
    

class CommandViewset(viewsets.ModelViewSet):
    queryset = models.Command.objects.all()
    serializer_class = serializers.CommandSerializer


class InformationViewset(viewsets.ModelViewSet):
    queryset = models.Information.objects.all()
    serializer_class = serializers.InformationSerializer


class FeedbackViewset(viewsets.ModelViewSet):
    queryset = models.Feedback.objects.all()
    serializer_class = serializers.FeedbackSerializer
    permission_classes = (UserBasedPermission,)
    action_permissions = {
        IsAuthenticated: ['POST'],
        #AllowAny: ['retrieve']
    }


class ImageViewset(viewsets.ModelViewSet):
    queryset = models.Image.objects.all()
    serializer_class = serializers.ImageSerializer


####--------------For convenience-------------
class PetsViewset1(viewsets.ModelViewSet):
    queryset = models.Pet.objects.all()
    serializer_class = serializers.PetSerializer


class CalendarViewset1(viewsets.ModelViewSet):
    queryset = models.Calendar.objects.all()
    serializer_class = serializers.CalendarSerializer