<?php

namespace Database\Seeders;

use App\Models\Anexo;
use App\Models\AnexoDetalle;
use App\Models\AnexoRecurso;
use App\Models\ControlHoras;
use App\Models\DetalleOrdenServicio;
use App\Models\EstadoOrden;
use App\Models\Horario;
use App\Models\OrdenServicio;
use App\Models\Recurso;
use App\Models\Sectore;
use App\Models\ServicioGrua;
use App\Models\Vehiculo;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class OsgoDatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Desactivar restricciones de clave foránea temporalmente
        DB::statement('SET FOREIGN_KEY_CHECKS=0');

        // Limpiar tablas
        DB::table('osgo_anexo_recurso')->truncate();
        DB::table('osgo_anexo_detalle')->truncate();
        DB::table('osgo_anexo')->truncate();
        DB::table('osgo_detalle_orden_servicio')->truncate();
        DB::table('osgo_control_horas')->truncate();
        DB::table('osgo_orden_servicio')->truncate();
        
        // Crear estado de orden
        $estado = EstadoOrden::create([
            'ESTADO_ORDEN' => 'Pendiente',
            'DESCRIPCION' => 'Orden pendiente de atención',
        ]);

        // Crear recurso
        $recurso = Recurso::create([
            'NOMBRE_RECURSO' => 'Recurso de Prueba',
            'TIPO_RECURSO' => 'Humano',
            'DESCRIPCION' => 'Recurso de prueba para desarrollo',
            'UNIDAD_MEDIDA' => 'Unidad',
            'ACTIVO' => 1  // Usar 1 para activo, 0 para inactivo
        ]);

        // Crear horario
        $horario = Horario::create([
            'NOMBRE' => 'Turno Mañana',
            'HORA_INICIO' => '08:00:00',
            'HORA_FIN' => '16:00:00',
            'DESCRIPCION' => 'Jornada laboral estándar',
            'DURACION_HORAS' => 8,
            'ACTIVO' => 1  // Usar 1 para activo, 0 para inactivo
        ]);

        // Crear orden de servicio
        $orden = OrdenServicio::create([
            'NRO_ORDEN' => 'ORD-' . date('YmdHis'),
            'FECHA' => now()->format('Y-m-d'),
            'DISTRITO' => 'Distrito Central',
            'PROVINCIA' => 'Provincia Central',
            'CIUDAD' => 'Ciudad Principal',
            'CREADO_POR' => 1, // Asumiendo que el usuario con ID 1 existe
            'ID_ESTADO_ORDEN' => $estado->ID_ESTADO_ORDEN,
            'FECHA_ACTUAL' => now()
        ]);

        // Crear detalle de orden de servicio
        $detalle = DetalleOrdenServicio::create([
            'ID_ORDEN_SERVICIO' => $orden->ID_ORDEN_SERVICIO,
            'ID_FUNCION' => 1, // Asumiendo que existe la función con ID 1
            'GRUPO_FUNCIONAL' => 'Operativo',
            'FUNCION' => 'Soporte Técnico',
            'CODIGO_RESPONSABLE' => 'EMP-001',
            'RESPONSABLE' => 'Juan Pérez',
            'SECTOR' => 'Tecnología',
            'NOVEDADES' => 'Sin novedades',
            'OBSERVACION' => 'Prueba de registro'
        ]);

        // Crear anexo
        $anexo = Anexo::create([
            'ID_ORDEN_SERVICIO' => $orden->ID_ORDEN_SERVICIO,
            'TIPO_ANEXO' => 'Soporte',
            'NOMBRE' => 'Anexo de prueba',
            'ORGANIZADOR' => 'Departamento de TI',
            'TELEFONO_ORGANIZADOR' => '0999999999',
            'FECHA' => now()->format('Y-m-d'),
            'HORA_FORMACION' => '08:00:00',
            'HORA_INICIO' => '09:00:00',
            'HORA_FIN' => '17:00:00',
            'LUGAR' => 'Oficina Central',
            'MANDO' => 'Jefe de Departamento',
            'JEFE_CONTROL' => 'Supervisor de Turno',
            'MISION' => 'Soporte técnico general',
            'GESTION_REQUERIDA' => 'Mantenimiento preventivo',
            'RECORRIDO' => 'Oficinas principales',
            'ANTECEDENTES' => 'Sin antecedentes',
            'INSTRUCCIONES_COORDINACION' => 'Seguir protocolo estándar',
            'RUTAGRAMA_IMAGEN' => null,
            'NOTAS_RUTAGRAMA' => null,
            'ESTADO' => 'Activo',
            'CREADO_POR' => 1
        ]);

        // Crear detalle de anexo
        $anexoDetalle = AnexoDetalle::create([
            'ID_ANEXO' => $anexo->ID_ANEXO,
            'ORDEN' => 1,
            'RESPONSABLE' => 'Técnico de Soporte',
            'FUNCION' => 'Soporte Técnico',
            'PUESTO_SERVICIO' => 'Oficina',
            'OBSERVACION' => 'Asignado para mantenimiento'
        ]);

        // Crear relación anexo-recurso
        AnexoRecurso::create([
            'ID_ANEXO' => $anexo->ID_ANEXO,
            'ID_RECURSO' => $recurso->ID_RECURSO,
            'TIPO_RECURSO' => 'Humano',
            'CANTIDAD' => 1,
            'OBSERVACIONES' => 'Asignación de recurso para soporte'
        ]);

        // Crear control de horas
        ControlHoras::create([
            'ID_PERSONA' => 1, // Asumiendo que existe la persona con ID 1
            'FECHA' => now()->format('Y-m-d'),
            'HORAS_TRABAJADAS' => 8,
            'ESTADO' => 'Completado'
        ]);

        // Crear servicio de grúa
        ServicioGrua::create([
            'PROPIETARIO' => 'Empresa de Grúas S.A.',
            'CONTRATO' => 'CON-' . date('Ymd'),
            'TELEFONO' => '022222222'
        ]);

        // Reactivar restricciones de clave foránea
        DB::statement('SET FOREIGN_KEY_CHECKS=1');
    }
}
