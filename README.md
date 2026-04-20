# Coding Interview Frontend

Aplicación Flutter para cotización e intercambio de divisas (fiat y cripto), con manejo de estado en Riverpod, enrutamiento con GoRouter, localización ES/EN y pruebas automatizadas.

## Objetivo

Este proyecto implementa una pantalla de intercambio donde el usuario puede:

- Seleccionar moneda fiat y cripto.
- Ingresar un monto y obtener cotización estimada.
- Invertir la operación (swap) entre compra/venta.
- Ver estados de carga, error y combinaciones sin ofertas.
- Confirmar la operación y reiniciar la vista.

## Stack Técnico

- Flutter (SDK Dart ^3.11.4)
- Estado: flutter_riverpod + riverpod_annotation
- Inyección de dependencias: get_it
- Networking: dio
- Navegación: go_router
- Imágenes remotas: cached_network_image
- Localización: intl + flutter_localizations + gen-l10n
- Testing: flutter_test

## Funcionalidades Principales

- Cotización por API para pares de monedas.
- Carga de monedas disponibles desde API.
- Manejo explícito de errores de negocio:
  - monto inválido
  - cripto no soportada
  - ausencia de ofertas
- Mensajes de UI localizados (es/en).
- Sanitización de texto de monto para evitar entradas inválidas.

## Endpoints Consumidos

La app consume los siguientes endpoints HTTP (GET):

- `https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/currencies`
- `https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/orderbook/public/recommendations`

## Arquitectura

El código sigue una separación por capas y por feature:

- `data`: implementación concreta de repositorios.
- `domain`: entidades y contratos.
- `presentation`: pantallas, widgets, estado y providers.
- `core`: servicios transversales, modelos compartidos, utilidades y setup.

Estructura base:

```text
lib/
	main.dart
	src/
		app.dart
		routes/
		core/
			services/
			setup/
			models/
			providers/
			constants/
			utils/
		features/
			home/
				data/
				domain/
				presentation/
	l10n/
		app_en.arb
		app_es.arb
		generated/
```

## Requisitos

- Flutter SDK compatible con Dart `^3.11.4`
- Xcode (iOS/macOS) y/o Android Studio según plataforma objetivo

Verifica instalación:

```bash
flutter --version
flutter doctor
```

## Instalación

```bash
flutter pub get
```

## Ejecutar la app

```bash
flutter run
```

Para elegir dispositivo:

```bash
flutter devices
flutter run -d <device_id>
```

## Pruebas

Ejecutar tests:

```bash
flutter test
```

Ejecutar tests con cobertura:

```bash
flutter test --coverage
```

El reporte se genera en:

- `coverage/lcov.info`

## Generación de Código

El proyecto usa generación para Riverpod (`*.g.dart`).

Generar una vez:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Modo watch:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## Localización (i18n)

Idiomas disponibles:

- Español (`es`)
- Inglés (`en`)

Configuración en `l10n.yaml`:

- `arb-dir: lib/l10n`
- `template-arb-file: app_en.arb`
- `output-dir: lib/l10n/generated`

Archivo generado principal:

- `lib/l10n/generated/app_localizations.dart`

## Calidad de Código

Análisis estático:

```bash
flutter analyze
```

Formateo:

```bash
dart format .
```

## Estado Actual

- Feature implementada: `home`.
- Ruta principal: `/`.
- El `HomeRepository` usa una implementación mock/simulada para datos base de UI.
- Las cotizaciones reales y monedas disponibles se obtienen mediante `OrderbookRecommendationsService`.
