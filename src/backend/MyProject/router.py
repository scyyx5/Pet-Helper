from backend .viewsets import *
from rest_framework import routers
from django.contrib.auth.models import User

router = routers.DefaultRouter()
#--------below is final version
router.register('api/v3/Pets', PetViewset)
router.register('api/v3/Users/<str:pkt>/Pets', PetViewset)    #hope it works TAT
router.register('api/v3/Calendars', CalendarViewset)
router.register('api/v3/Users/<str:pkt>/Calendars', CalendarViewset)    #hope it works TAT
router.register('api/v3/Commands', CommandViewset)
router.register('api/v3/Information', InformationViewset)
router.register('api/v3/Feedback', FeedbackViewset)
router.register('api/v3/Settings', PetOwner2sViewset)
router.register('api/v3/Users/<str:pkt>/Settings', PetOwner2sViewset)    #hope it works TAT
router.register('api/v3/Users', PetUsersViewset)

router.register('v1/PetOwner', PetOwnersViewset)
router.register('v1/Pet', PetViewset)
router.register('v1/Pet1', PetsViewset1)   # with all permission
router.register('v1/Calendar1', CalendarViewset1)   # with all permission
router.register('v1/Calendar', CalendarViewset)
router.register('v1/Command', CommandViewset)
router.register('v1/Information', InformationViewset)
router.register('v1/Feedback', FeedbackViewset)
router.register('v1/Image', ImageViewset)
router.register('v2/PetOwner', PetOwner2sViewset)
router.register('v2/PetOwner1', PetOwner2sViewset1)
router.register('v2/User', PetUsersViewset)