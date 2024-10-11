from django.contrib import admin
from django.urls import path, include
from backend.views import *
from .router import router
from django.conf import settings
from django.conf.urls.static import static
'''
from rest_framework.urlpatterns import format_suffix_patterns
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)
'''
from rest_framework.authtoken import views
from rest_framework.authtoken.views import obtain_auth_token
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from django.urls import re_path
from django.views.generic.base import TemplateView # new


schema_view = get_schema_view(
   openapi.Info(
      title="Snippets API",
      default_version='v3',
      description="Test description",
      terms_of_service="https://www.google.com/policies/terms/",
      contact=openapi.Contact(email="contact@snippets.local"),
      license=openapi.License(name="BSD License"),
   ),
   public=True,
   permission_classes=[permissions.AllowAny],
)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(router.urls)),
    #--------below is the url in final version
    #path('api/v3/Calendars/<str:pk>/byowner', calendar_detail_owner),
    path('api/v3/Articles/1/', getCatArticle),
    path('api/v3/Articles/2/', getDogArticle),
    path('api/v3/Articles/CatArticles/', getCatArticle),
    path('api/v3/Articles/DogArticles/', getDogArticle),
    #path('api/v3/PostFeedback/', postFeedback),
    path('api/v3/Pets_byowner/', pet_detail_owner2),
    path('api/v3/Users/<str:pk>/Pets/', pet_detail_owner),
    path('api/v3/login/', logIn2,name = 'user log in'),
    #path('api/v3/User/login/', logIn2,name = 'user log in'),
    path('api/v3/Register/',Register.as_view(), name='auth_register'),
    path('api/v3/calendars_byowner/', calendar_byowner),
    path('api/v3/Users/<str:pk>/Calendars/', calendar_byowner),

    
    #----------below is used for documentation
    #reference: https://github.com/axnsan12/drf-yasg/
    re_path(r'^swagger(?P<format>\.json|\.yaml)$', schema_view.without_ui(cache_timeout=0), name='schema-json'),
    re_path(r'^swagger/$', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    re_path(r'^redoc/$', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),

    #path('auth/',include('django.contrib.auth.urls')), do we really need that????
    #path('v1/Pet/<str:pk>/byowner/', pet_detail_owner),
    path('v1/Pet/<str:pk>/byowner/', pet_detail_owner),
    path('v1/Calendar/<str:pk>/byowner/', calendar_detail_owner),
    path('v1/Article/CatArticles/', getCatArticle),
    path('v1/Article/DogArticles/', getDogArticle),
    path('v1/Article/1/', getCatArticle),
    path('v1/Article/2/', getDogArticle),
    path('v1/PostFeedback/', postFeedback),
    path('v1/Petowner/<str:em>/<str:pw>/login/', logIn),
    path('v2/Pet/byowner/', pet_detail_owner2),
    path('v2/User/login/', logIn2),
    path('v2/Register/',Register.as_view(), name='auth_register'),
    #path('auth/',include('django.contrib.auth.urls')), do we really need that????
    #path('v1/Pet/<str:pk>/byowner/', pet_detail_owner),
    #http://127.0.0.1:8000/v2/PetOwner/
    #path('api/v3/login/',MyObtainTokenPairView.as_view(), name='token_obtain_pair'),
    #path('api/v3/login/refresh/',TokenRefreshView.as_view(), name='token_refresh'),
    #path('api-token-auth/', CustomAuthToken.as_view()),
    #path('api-token-auth/', views.obtain_auth_token)
]+static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)





