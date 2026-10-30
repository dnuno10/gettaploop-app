import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme_extensions.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return _LegalDocumentPage(
      title: 'Terminos y condiciones',
      intro:
          'Estos Terminos y Condiciones regulan el acceso, navegacion y uso de la plataforma TapLoop. Al utilizar el software, el usuario acepta estas disposiciones y reconoce que su cuenta, su contenido y sus acciones dentro del sistema deben apegarse a este marco.',
      sections: const [
        _LegalSection(
          title: '1. Alcance del servicio',
          paragraphs: [
            'TapLoop es una plataforma de software orientada a la gestion de perfiles digitales, tarjetas NFC, comparticion de informacion profesional, seguimiento de interacciones, captacion de leads, analiticas comerciales y herramientas relacionadas con networking y operacion comercial.',
            'El servicio puede incluir panel administrativo, modulos de configuracion de perfiles, componentes de visualizacion publica, herramientas de medicion, formularios inteligentes y funcionalidades de activacion vinculadas a tarjetas NFC o identificadores similares.',
          ],
          bullets: [
            'El acceso al software puede depender de credenciales emitidas por TapLoop o por un administrador autorizado.',
            'Algunas funciones pueden variar segun el tipo de cuenta, configuracion interna, entorno de despliegue o version del producto.',
            'TapLoop puede introducir cambios, mejoras, restricciones o sustituciones funcionales cuando lo considere necesario.',
          ],
        ),
        _LegalSection(
          title: '2. Definiciones basicas',
          paragraphs: [
            'Para efectos de este documento, los siguientes terminos se interpretan de la siguiente manera.',
          ],
          bullets: [
            'Plataforma: el software TapLoop y sus modulos asociados.',
            'Usuario: persona fisica autorizada para acceder a la plataforma.',
            'Cuenta: conjunto de credenciales, configuraciones y datos asociados a un usuario.',
            'Contenido: informacion, imagenes, logotipos, enlaces, perfiles, formularios, textos y datos cargados por el usuario o por su organizacion.',
            'Organizacion: empresa, equipo o entidad para la cual se utiliza la plataforma.',
            'Lead: registro generado por interacciones comerciales dentro del software.',
          ],
        ),
        _LegalSection(
          title: '3. Registro, acceso y seguridad de la cuenta',
          paragraphs: [
            'El usuario debe proporcionar datos veraces, completos y actualizados para operar correctamente su cuenta y los modulos asociados.',
            'Cada cuenta es de uso personal o institucional autorizado. El usuario es responsable de preservar la confidencialidad de sus credenciales y de evitar accesos no autorizados.',
          ],
          bullets: [
            'No compartir contraseñas con terceros no autorizados.',
            'No suplantar identidad ni utilizar credenciales ajenas.',
            'Notificar incidentes de seguridad o accesos sospechosos en cuanto sean detectados.',
            'Mantener actualizada la informacion esencial del perfil cuando sea necesaria para la operacion.',
          ],
        ),
        _LegalSection(
          title: '4. Uso permitido y restricciones',
          paragraphs: [
            'La plataforma debe utilizarse exclusivamente para fines licitos, profesionales, comerciales o administrativos compatibles con la naturaleza del servicio.',
          ],
          bullets: [
            'No utilizar TapLoop para fraude, engaño, phishing, spam o actividades ilicitas.',
            'No cargar contenido que vulnere derechos de terceros, normas de propiedad intelectual o disposiciones legales aplicables.',
            'No intentar acceder a informacion, cuentas, modulos o recursos sin autorizacion.',
            'No interferir con la estabilidad, seguridad o disponibilidad del sistema.',
            'No introducir codigo malicioso, automatizaciones abusivas o mecanismos de extraccion no autorizada.',
          ],
        ),
        _LegalSection(
          title: '5. Contenido del usuario y responsabilidad editorial',
          paragraphs: [
            'El usuario conserva responsabilidad sobre todo contenido que publique, cargue, sincronice o mantenga visible dentro de la plataforma.',
            'TapLoop no asume validacion editorial previa sobre perfiles, biografias, logos, enlaces, formularios, materiales comerciales o datos de contacto cargados por el usuario o su organizacion.',
          ],
          bullets: [
            'El usuario garantiza que cuenta con derechos o autorizaciones suficientes sobre el contenido que sube.',
            'El usuario acepta corregir o retirar informacion incorrecta, desactualizada o conflictiva cuando corresponda.',
            'TapLoop puede restringir contenido que comprometa la operacion, seguridad o cumplimiento normativo del sistema.',
          ],
        ),
        _LegalSection(
          title: '6. Modulos NFC, perfiles digitales y comparticion publica',
          paragraphs: [
            'Cuando la plataforma opere en conjunto con tarjetas NFC, codigos QR u otros identificadores, el usuario reconoce que la informacion visible publicamente en su perfil puede ser consultada por terceros a traves de navegadores o enlaces compartidos.',
            'La activacion, vinculacion o uso de tarjetas fisicas depende tanto del software como de infraestructura externa, compatibilidad de dispositivos y configuraciones operativas.',
          ],
          bullets: [
            'TapLoop no garantiza compatibilidad universal con todos los dispositivos del mercado.',
            'La vinculacion de tarjetas puede estar sujeta a reglas internas de asignacion y seguridad.',
            'La informacion visible publicamente sera la configurada por el usuario o por su organizacion en la plataforma.',
          ],
        ),
        _LegalSection(
          title: '7. Analiticas, leads y herramientas de seguimiento',
          paragraphs: [
            'TapLoop puede registrar eventos de uso, visitas, taps, clicks, envios de formularios y otras interacciones orientadas a medicion comercial, priorizacion de seguimiento y operacion interna.',
            'Las metricas mostradas en la plataforma son informativas y pueden depender de integridad de datos, conectividad, configuraciones del navegador, bloqueadores, entornos anonimos o eventos no atribuibles con precision absoluta.',
          ],
          bullets: [
            'Las analiticas no constituyen auditoria forense ni prueba legal por si mismas.',
            'Los leads y eventos pueden depender de acciones reales de terceros fuera del control de TapLoop.',
            'Los reportes pueden cambiar conforme se actualice la logica de procesamiento o el modelo de datos.',
          ],
        ),
        _LegalSection(
          title: '8. Propiedad intelectual',
          paragraphs: [
            'La arquitectura del software, su codigo, componentes, diseño visual, flujos funcionales, nombres comerciales, marcas, identidad grafica y materiales propios de TapLoop son propiedad de sus respectivos titulares y se encuentran protegidos por la normativa aplicable.',
            'Nada en estos Terminos transfiere al usuario derechos de propiedad sobre la plataforma, salvo el derecho limitado, revocable y no exclusivo de utilizarla conforme a este documento.',
          ],
        ),
        _LegalSection(
          title: '9. Disponibilidad, cambios y mantenimiento',
          paragraphs: [
            'TapLoop puede realizar tareas de mantenimiento, actualizaciones, cambios de arquitectura, ajustes visuales, refactorizaciones, restricciones temporales o modificaciones funcionales sin previo aviso cuando sea razonablemente necesario.',
            'Aunque se procura alta disponibilidad, el servicio se ofrece bajo un criterio de operacion razonable y no bajo una garantia absoluta de continuidad ininterrumpida.',
          ],
        ),
        _LegalSection(
          title: '10. Integraciones y servicios de terceros',
          paragraphs: [
            'La plataforma puede depender de proveedores externos para autenticacion, almacenamiento, hosting, analitica, entrega de correos, infraestructura o conectividad. El uso de dichos servicios puede impactar parcial o totalmente la operacion del software.',
          ],
          bullets: [
            'TapLoop no controla de forma directa los terminos de terceros.',
            'Una falla externa puede afectar funciones especificas sin que ello implique incumplimiento absoluto del servicio.',
            'El usuario reconoce que algunos enlaces o acciones pueden abrir recursos fuera de la plataforma.',
          ],
        ),
        _LegalSection(
          title: '11. Suspension o terminacion',
          paragraphs: [
            'TapLoop puede limitar, suspender o terminar acceso cuando detecte incumplimientos a estos Terminos, riesgos operativos, uso abusivo, vulneraciones de seguridad o situaciones que comprometan a otros usuarios, a la organizacion o a la plataforma.',
          ],
          bullets: [
            'Suspension preventiva por seguridad.',
            'Limitacion funcional por mantenimiento o incidencias.',
            'Cierre de acceso por incumplimiento grave.',
          ],
        ),
        _LegalSection(
          title: '12. Limitacion de responsabilidad',
          paragraphs: [
            'En la medida permitida por la ley aplicable, TapLoop no sera responsable por daños indirectos, incidentales, consecuenciales, lucro cesante, perdida de oportunidades, perdida de datos, afectaciones reputacionales o impactos derivados del uso o imposibilidad de uso de la plataforma.',
            'El usuario acepta que el software es una herramienta de apoyo operativo y comercial, y que las decisiones de negocio siguen siendo responsabilidad exclusiva del usuario o de su organizacion.',
          ],
        ),
        _LegalSection(
          title: '13. Modificaciones a estos terminos',
          paragraphs: [
            'TapLoop puede actualizar este documento para reflejar cambios operativos, legales, comerciales o tecnicos. La version publicada dentro del software sustituira a cualquier version previa a partir de su publicacion.',
          ],
        ),
      ],
    );
  }
}

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return _LegalDocumentPage(
      title: 'Politicas de privacidad',
      intro:
          'Esta Politica describe como TapLoop recopila, utiliza, conserva y protege informacion relacionada con usuarios, perfiles, tarjetas NFC, interacciones comerciales y demas datos tratados por la plataforma. El objetivo es explicar de forma clara el tratamiento de la informacion dentro del software.',
      sections: const [
        _LegalSection(
          title: '1. Tipos de informacion que recopilamos',
          paragraphs: [
            'TapLoop puede recopilar informacion que el usuario proporciona directamente, informacion generada por el uso del software e informacion tecnica necesaria para operar la plataforma.',
          ],
          bullets: [
            'Datos de acceso: correo, credenciales, identificadores de cuenta.',
            'Datos de perfil: nombre, puesto, empresa, fotografia, biografia, enlaces y datos de contacto.',
            'Datos operativos: configuraciones de tarjeta, logos, layouts, colores, formularios y preferencias.',
            'Datos de interaccion: visitas, taps, clicks, formularios enviados, leads y eventos relacionados.',
            'Datos tecnicos: identificadores de sesion, navegador, dispositivo, tiempos de acceso y metadatos operativos.',
          ],
        ),
        _LegalSection(
          title: '2. Finalidades del tratamiento',
          paragraphs: [
            'La informacion tratada por TapLoop se utiliza para habilitar las funciones principales del software y sostener la operacion del servicio.',
          ],
          bullets: [
            'Autenticar y administrar cuentas.',
            'Mostrar perfiles publicos o privados segun configuracion.',
            'Vincular tarjetas NFC y recursos digitales asociados.',
            'Generar analiticas, reportes, priorizacion comercial y seguimiento de leads.',
            'Brindar soporte, mantenimiento, seguridad y mejoras del producto.',
            'Cumplir obligaciones operativas, contractuales o legales aplicables.',
          ],
        ),
        _LegalSection(
          title: '3. Base operativa para el uso de la informacion',
          paragraphs: [
            'TapLoop trata informacion en la medida en que resulta necesaria para prestar el servicio, administrar accesos, ejecutar funcionalidades solicitadas por el usuario u organizacion y proteger la integridad del entorno.',
            'Cuando una organizacion utiliza TapLoop para su equipo, parte del tratamiento puede derivar de la relacion interna entre la organizacion y sus usuarios autorizados.',
          ],
        ),
        _LegalSection(
          title: '4. Informacion visible para terceros',
          paragraphs: [
            'Algunas funciones de TapLoop implican que cierta informacion del perfil del usuario sea visible publicamente al compartir una tarjeta digital, un QR, un enlace o un identificador NFC.',
            'La visibilidad de esos datos depende de la configuracion del perfil, de los elementos activados y de la forma en que el usuario o su organizacion utilicen la plataforma.',
          ],
          bullets: [
            'Nombre profesional.',
            'Cargo o puesto.',
            'Empresa.',
            'Logotipo, foto y elementos visuales publicados.',
            'Datos de contacto y enlaces que el usuario marque como visibles.',
          ],
        ),
        _LegalSection(
          title: '5. Leads, formularios y eventos comerciales',
          paragraphs: [
            'TapLoop puede registrar informacion proporcionada por terceros cuando interactuan con formularios, enlaces, llamadas a la accion o mecanismos de captacion vinculados a perfiles digitales.',
            'Dicha informacion puede ser utilizada por el usuario o la organizacion para seguimiento comercial, analisis de desempeño y administracion interna de oportunidades.',
          ],
        ),
        _LegalSection(
          title: '6. Comparticion con terceros',
          paragraphs: [
            'TapLoop no comercializa informacion personal como producto independiente. Sin embargo, puede compartir o procesar informacion a traves de proveedores tecnologicos necesarios para operar la plataforma.',
          ],
          bullets: [
            'Servicios de autenticacion y gestion de sesiones.',
            'Infraestructura de almacenamiento o base de datos.',
            'Hosting, despliegue y distribucion de contenido.',
            'Herramientas de entrega operativa o soporte tecnico.',
          ],
        ),
        _LegalSection(
          title: '7. Retencion y conservacion',
          paragraphs: [
            'La informacion se conserva durante el tiempo razonablemente necesario para prestar el servicio, mantener continuidad operativa, resolver incidencias, generar historicos utiles y cumplir obligaciones internas o legales.',
            'Determinados registros tecnicos, historicos de eventos o trazas operativas pueden conservarse por periodos adicionales con fines de seguridad, auditoria o soporte.',
          ],
        ),
        _LegalSection(
          title: '8. Seguridad de la informacion',
          paragraphs: [
            'TapLoop implementa medidas tecnicas y organizativas razonables para proteger la informacion frente a acceso no autorizado, alteracion, perdida, destruccion o divulgacion indebida.',
            'Aun asi, ningun sistema conectado a internet puede garantizar seguridad absoluta. El usuario tambien tiene responsabilidad sobre el manejo de sus credenciales y del contenido que administra.',
          ],
          bullets: [
            'Control de acceso por autenticacion.',
            'Separacion funcional entre vistas publicas y privadas.',
            'Proteccion razonable de almacenamiento y transporte de datos.',
            'Monitoreo y ajustes operativos cuando sea necesario.',
          ],
        ),
        _LegalSection(
          title: '9. Derechos y solicitudes del usuario',
          paragraphs: [
            'El usuario puede solicitar correccion, actualizacion o revision de ciertos datos asociados a su cuenta, sujeto a las capacidades operativas del sistema, a la relacion contractual aplicable y a los limites legales o administrativos correspondientes.',
          ],
          bullets: [
            'Actualizar informacion del perfil.',
            'Corregir datos inexactos.',
            'Solicitar baja o restriccion cuando proceda.',
            'Consultar la informacion visible que mantiene en su perfil.',
          ],
        ),
        _LegalSection(
          title: '10. Cookies, identificadores y analitica tecnica',
          paragraphs: [
            'TapLoop puede utilizar identificadores de sesion, almacenamiento local del navegador, elementos tecnicos equivalentes a cookies y mecanismos de medicion interna necesarios para mantener la sesion, recordar preferencias, validar eventos y mejorar la plataforma.',
          ],
        ),
        _LegalSection(
          title: '11. Menores de edad',
          paragraphs: [
            'La plataforma esta orientada a uso profesional, comercial o corporativo. No esta diseñada para que menores de edad la utilicen de forma independiente sin supervision o autorizacion valida cuando esta sea exigible.',
          ],
        ),
        _LegalSection(
          title: '12. Transferencias y operacion internacional',
          paragraphs: [
            'Dependiendo de la infraestructura tecnica utilizada para operar TapLoop, cierta informacion puede ser procesada o almacenada en entornos tecnologicos ubicados en distintas jurisdicciones. En esos casos se procuraran medidas razonables de proteccion conforme a la operacion del servicio.',
          ],
        ),
        _LegalSection(
          title: '13. Cambios a esta politica',
          paragraphs: [
            'TapLoop puede actualizar esta Politica de Privacidad para reflejar cambios del producto, de la operacion, de la arquitectura tecnica o de la normativa aplicable. La version publicada dentro del software sera la referencia vigente.',
          ],
        ),
      ],
    );
  }
}

class _LegalDocumentPage extends StatelessWidget {
  final String title;
  final String intro;
  final List<_LegalSection> sections;

  const _LegalDocumentPage({
    required this.title,
    required this.intro,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgPage,
      appBar: AppBar(
        backgroundColor: context.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: context.textPrimary,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 48),
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: context.textPrimary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                intro,
                style: GoogleFonts.dmSans(
                  fontSize: 15,
                  color: context.textSecondary,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 28),
              Divider(color: context.borderColor),
              const SizedBox(height: 24),
              Text(
                'Indice',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              ...sections.map(
                (section) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    section.title,
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color: context.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              ...sections.map((section) => _SectionBlock(section: section)),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'TapLoop 2026',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                    color: context.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final _LegalSection section;

  const _SectionBlock({required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: context.textPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          ...section.paragraphs.map(
            (paragraph) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                paragraph,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: context.textSecondary,
                  height: 1.75,
                ),
              ),
            ),
          ),
          if (section.bullets.isNotEmpty) ...[
            const SizedBox(height: 4),
            ...section.bullets.map(
              (bullet) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        bullet,
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: context.textSecondary,
                          height: 1.7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          Divider(color: context.borderColor, height: 28),
        ],
      ),
    );
  }
}

class _LegalSection {
  final String title;
  final List<String> paragraphs;
  final List<String> bullets;

  const _LegalSection({
    required this.title,
    this.paragraphs = const [],
    this.bullets = const [],
  });
}
