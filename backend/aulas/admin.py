from django.contrib import admin
from .models import Carrera, Profesor, Materia, Aula, Reserva_aula, Horario_materia

admin.site.register(Carrera)
admin.site.register(Profesor)
admin.site.register(Materia)
admin.site.register(Aula)
admin.site.register(Reserva_aula)
admin.site.register(Horario_materia)