from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from .serializers import *
from .models import *
from rest_framework import status
from django.contrib.auth.models import User
from django.contrib.auth import authenticate,login,get_user_model
from django.contrib.auth.backends import ModelBackend
from django.db.models import Q
from rest_framework import generics
from rest_framework.permissions import AllowAny,IsAuthenticated
from .serializers import MyTokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.authtoken.models import Token
from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.decorators import api_view, permission_classes


'''
@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)
'''
#__________________________________token___________________________________
##this is used to generate token. Don't understand now
'''
generate in comman line:
./manage.py drf_create_token <username>
regenerate the token:
./manage.py drf_create_token -r <username>
'''

class CustomAuthToken(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user_id': user.pk,
            'email': user.email
        })


class MyObtainTokenPairView(TokenObtainPairView):
    permission_classes = (AllowAny,)
    serializer_class = MyTokenObtainPairSerializer


#__________________________________login views___________________________________
@api_view(['POST'])
@permission_classes([AllowAny])
#@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def logIn2(request):
    try:
        data = request.data
        email=data["email"]
        password = data["password"]
        print(email,password)
        isUser = my_authenticate(email,password)
        if isUser is not None:
            user2 = User.objects.filter(username=isUser)
            user = User.objects.get(username=isUser)
            serializer = PetUserSerializer(user2, many=True)
            token = Token.objects.get_or_create(user=user)   ###successfully generated. But how to use it?????????
            data = serializer.data
            print(data)
            return Response({'user':data[0],"token":token[0].key},status=status.HTTP_200_OK)
        else:
            return Response({'error': 'Invalid Credentials'},
                        status=status.HTTP_400_BAD_REQUEST)
    except:
        return Response({'error': 'Please provide both username and password'},status=status.HTTP_404_NOT_FOUND)


#improve: password more secure, return 404 if wrong.
def my_authenticate(emailOrUsername,password):

    #checking if the user entered email or username to log in
    if emailOrUsername.__contains__('@'):
        user = User.objects.filter(email=emailOrUsername).first()
    else:
        user = User.objects.filter(username=emailOrUsername).first()
    # checking if the password is correct
    if user:
        is_correct = user.check_password(password)
        if is_correct:
            return user
        else:
            print('Wrong password')
            return None
    else:
        print('Cannot find the user')
        return None


#___________________________register views______________________________ No authentication required
class Register(generics.CreateAPIView):
    try:
        queryset = User.objects.all()
        permission_classes = (AllowAny,)
        serializer_class = RegisterSerializer
        print("yeah")
    #    return Response(status=status.HTTP_200_OK)
    except:
        print("www")
    #    return Response(serializer.data,status=status.HTTP_200_OK)
        


#___________________________pet views______________________________ Authentication required
# return all the pet of a user by their ID

@api_view(['GET','DELETE'])
@permission_classes((IsAuthenticated,))
def pet_detail_owner(request, pk):
    try:
        pet_owner = User.objects.get(id=pk)
        pets = pet_owner.pet_set.all()
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)

    # Get Pets from the owner ID
    if request.method == 'GET':
        pet_owner = User.objects.get(id=pk)
        pets = pet_owner.pet_set.all()
        serializer = PetSerializer(pets, many=True)
        return Response(serializer.data)

    #used when delete user.Works now
    elif request.method == 'DELETE':
        pets.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

@api_view(['GET','DELETE'])
@permission_classes((IsAuthenticated,))
def pet_detail_owner2(request):
    try:
        id = request.user.id
        try:
            pet_owner = User.objects.get(id=id)
            pets = pet_owner.pet_set.all()
        except:
            return Response(status=status.HTTP_404_NOT_FOUND)
    except: 
        return Response(status=status.HTTP_401_UNAUTHORIZED)

            

    # Get Pets from the owner ID
    if request.method == 'GET':
        pet_owner = User.objects.get(id=id)
        pets = pet_owner.pet_set.all()
        serializer = PetSerializer(pets, many=True)
        return Response(serializer.data)


    #used when delete user.Works now
    elif request.method == 'DELETE':
        pets.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)



#______________________ articles__________________________ No authentication required

#Org
@api_view(['GET'])
def getDogArticle(request):
    articles = Information.objects.filter(category='Dog')
    serializer = InformationSerializer(articles, many=True)
    return Response(serializer.data)

# Get Cat Articles Done
@api_view(['GET'])
def getCatArticle(request):
    articles = Information.objects.filter(category='Cat')
    serializer = InformationSerializer(articles, many=True)
    return Response(serializer.data)
# end Org



#___________feedback____________________________________ Authentication required
@api_view(['POST'])
@permission_classes((IsAuthenticated,))
def postFeedback(request):
    data=request.data
    feedback = Feedback.objects.create(feedback=data['feedback'])
    serializer = FeedbackSerializer(feedback,many=False)
    return Response(serializer.data, status=status.HTTP_201_CREATED)


#______________________________This is used to get command__________________________________ No authentication required
@api_view(['GET'])
def getCommand(request,title):
    command = Command.objects.filter(title = title)
    serializer = CommandSerializer(command, many=True)
    return Response(serializer.data)


#____________________________________________This is used to upload image for AI_____________________________________
@api_view(['POST'])
def uploadImage(request):
    if request.method == 'POST':
        serializer = ImageSerializer(data=request.data,files=request.FILES)
        if serializer.is_valid():
            serializer.save()
            #type = run_example(request.FILES)
            #type = "Dog"
        #return Response(serializer.data, status=status.HTTP_201_CREATED)
        #return Response(type, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


#---------this is used to get event in calendar by owner id
@api_view(['GET','DELETE'])
@permission_classes((IsAuthenticated,))
def calendar_detail_owner(request, pk):
    """
    Retrieve, update or delete a pet.
    """
    try:
        id = request.user.id
        try:
            pet_owner = User.objects.get(id=id)
            pets = pet_owner.pet_set.all()
        except:
            return Response(status=status.HTTP_404_NOT_FOUND)
    except: 
        return Response(status=status.HTTP_401_UNAUTHORIZED)

    # Get Pets from the owner ID
    if request.method == 'GET':
        serializer = CalendarSerializer(request, many=True)
        return Response(serializer.data)

    #used when delete user.Works now
    elif request.method == 'DELETE':
        request.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)



#_______________________________calendar views_______________________________________________
@api_view(['GET','DELETE'])
@permission_classes((IsAuthenticated,))
def calendar_byowner(request,pk):
    try:
        id = request.user.id
        print(id)
        try:
            pet_owner = User.objects.get(id=id)
        except:
            return Response(status=status.HTTP_404_NOT_FOUND)
    except: 
        return Response(status=status.HTTP_401_UNAUTHORIZED)

            
    # Get Pets from the owner ID
    if request.method == 'GET':
        pet_owner = User.objects.get(id=id)
        calendar = pet_owner.calendar_set.all()
        serializer = CalendarSerializer(calendar, many=True)
        return Response(serializer.data)

    '''
    #used when delete user.Works now
    elif request.method == 'DELETE':
        pets.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
        '''



#________________________________old views____________________________________________________

#old login
@api_view(['GET'])
def logIn(request,em,pw):
    user = PetOwner.objects.filter(user_email=em, user_password=pw)
    serializer = PetUserSerializer(user, many=True)
    return Response(serializer.data)

# old auth
# def my_authenticate(email,password):
#     user = User.objects.filter(email=email).first()
#     if user:
#         is_correct = user.check_password(password)
#         if is_correct:
#             return user
#         else:
#             print('Wrong password')
#             return None
#     else:
#         print('Cannot find the user')
#         return None
