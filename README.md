
Presupuestos - App de Finanzas Personales 💸📊

Una aplicación de finanzas personales desarrollada con Flutter, que permite a los usuarios registrar ingresos y gastos, clasificarlos por categorías, aplicar filtros avanzados y visualizar estadísticas gráficas en tiempo real.

🚀 Características principales

- Registro de ingresos y gastos con:
  - Categorías personalizadas con íconos.
  - Comentarios y fecha seleccionable.
- Estadísticas:
  - Gráficas de pastel por categoría.
  - Filtros por periodo, tipo, título y categoría.
- Autenticación de usuarios (Firebase Auth).
- Persistencia en la nube usando Cloud Firestore.
- Interfaz moderna y responsive.
- Navegación usando go_router.
- Estado gestionado con flutter_bloc.

📦 Estructura del proyecto

Organizado en base a Clean Architecture:

lib/
├── core/              # Utilidades, constantes, inyección de dependencias, rutas
├── data/              # Modelos, fuentes de datos y repositorios
├── domain/            # Entidades y casos de uso
├── ui/                # Presentación (pantallas, widgets, BLoCs)

⚙️ Decisiones Técnicas

- Arquitectura limpia: separa claramente responsabilidades (datos, lógica, UI).
- Flutter BLoC: permite una gestión de estado escalable y testeable.
- Firebase Firestore: almacenamiento NoSQL flexible, ideal para datos por usuario.
- go_router: navegación declarativa y organizada con rutas nombradas.
- Filtros combinados: soporte para múltiples combinaciones de filtros sin recargar innecesariamente los datos.
- Diseño UI:
  - Uso de ExpansionTile para mostrar detalles como descripciones.
  - Cards con padding y estilo moderno.
  - SpeedDial para accesos rápidos a añadir ingresos/gastos.
  - Scroll sincronizado entre la gráfica y la lista de transacciones.

🔧 Dependencias clave

- flutter_bloc
- go_router
- cloud_firestore
- firebase_auth
- flutter_speed_dial
- fl_chart


🔐 Autenticación

Se utiliza FirebaseAuth para registrar e iniciar sesión. Los datos se almacenan por usuario bajo la colección:
users/{userId}/transactions.

🗂️ Filtros en estadísticas

- Periodo: Semana, Mes, Año (calculado dinámicamente).
- Categoría: Personalizadas y precargadas por tipo.
- Título: búsqueda parcial (no exacta).
- Tipo: Ingresos / Gastos (toggle).

🛠️ Instrucciones de desarrollo

1. Clonar el repositorio:
   git clone https://github.com/alejogrande/presupuestos.git
   cd presupuestos-app

2. Instalar dependencias:
   flutter pub get

3. Configurar Firebase:
   - Añade google-services.json en android/app/.
   - Añade GoogleService-Info.plist en ios/Runner/.

4. Ejecutar:
   flutter run

✍️ Autor
