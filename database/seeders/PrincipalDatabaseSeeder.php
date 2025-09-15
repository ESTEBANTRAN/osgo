<?php

namespace Database\Seeders;

use App\Models\Base\DistritosAgente;
use App\Models\Base\Funcione;
use App\Models\Base\GrupoOperativo;
use App\Models\Base\Indisponibilidad;
use App\Models\Base\Persona;
use App\Models\Base\Sistema;
use App\Models\Base\TipoGrupo;
use App\Models\Base\TipoIndisponibilidad;
use App\Models\Base\Usuario;
use App\Models\Base\UsuarioSistema;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class PrincipalDatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Establecer la conexión para todos los modelos
        config(['database.default' => 'principal']);
        
        // Crear distrito agente
        $distrito = DistritosAgente::create([
            'NOMBRE_DISTRITO' => 'Distrito Central',
            'ESTADO_DISTRITO' => 'Activo',
        ]);

        // Crear tipo de grupo
        $tipoGrupo = TipoGrupo::create([
            'TIPO_GRUPO' => 'Operativo',
            'DESCRIPCION' => 'Grupo operativo',
            'ESTADO' => 'Activo',
        ]);

        // Crear grupo operativo
        $grupoOperativo = GrupoOperativo::create([
            'NOMBRE_GRUPO' => 'Grupo Operativo 1',
            'DESCRIPCION' => 'Equipo de operaciones',
            'ESTADO' => 'Activo',
        ]);

        // Crear funciones basadas en las órdenes de servicio
        $funciones = [
            [
                'FUNCION' => 'GERENTE OPERATIVO DE TRÁNSITO',
                'ESTADO_FUNCION' => 'Activo',
                'ID_GRUPO_OPERATIVO' => $grupoOperativo->ID_GRUPO_OPERATIVO,
            ],
            [
                'FUNCION' => 'JEFE DE TRÁNSITO',
                'ESTADO_FUNCION' => 'Activo',
                'ID_GRUPO_OPERATIVO' => $grupoOperativo->ID_GRUPO_OPERATIVO,
            ],
            [
                'FUNCION' => 'SUB JEFE DE TRÁNSITO',
                'ESTADO_FUNCION' => 'Activo',
                'ID_GRUPO_OPERATIVO' => $grupoOperativo->ID_GRUPO_OPERATIVO,
            ],
            [
                'FUNCION' => 'INSPECTOR DISTRITO CENTRO',
                'ESTADO_FUNCION' => 'Activo',
                'ID_GRUPO_OPERATIVO' => $grupoOperativo->ID_GRUPO_OPERATIVO,
            ],
            [
                'FUNCION' => 'INSPECTOR DISTRITO SUR',
                'ESTADO_FUNCION' => 'Activo',
                'ID_GRUPO_OPERATIVO' => $grupoOperativo->ID_GRUPO_OPERATIVO,
            ],
            [
                'FUNCION' => 'INSPECTOR DISTRITO NORTE',
                'ESTADO_FUNCION' => 'Activo',
                'ID_GRUPO_OPERATIVO' => $grupoOperativo->ID_GRUPO_OPERATIVO,
            ],
            [
                'FUNCION' => 'SUB INSPECTOR CANTÓN',
                'ESTADO_FUNCION' => 'Activo',
                'ID_GRUPO_OPERATIVO' => $grupoOperativo->ID_GRUPO_OPERATIVO,
            ],
            [
                'FUNCION' => 'CONDUCTOR GERENTE OPERATIVO DE TRÁNSITO',
                'ESTADO_FUNCION' => 'Activo',
                'ID_GRUPO_OPERATIVO' => $grupoOperativo->ID_GRUPO_OPERATIVO,
            ],
            [
                'FUNCION' => 'CONDUCTOR SUB JEFE DE TRÁNSITO',
                'ESTADO_FUNCION' => 'Activo',
                'ID_GRUPO_OPERATIVO' => $grupoOperativo->ID_GRUPO_OPERATIVO,
            ],
            [
                'FUNCION' => 'INSPECTOR DE CONTROL GENERAL',
                'ESTADO_FUNCION' => 'Activo',
                'ID_GRUPO_OPERATIVO' => $grupoOperativo->ID_GRUPO_OPERATIVO,
            ],
            [
                'FUNCION' => 'SUB INSPECTOR DE CONTROL GENERAL',
                'ESTADO_FUNCION' => 'Activo',
                'ID_GRUPO_OPERATIVO' => $grupoOperativo->ID_GRUPO_OPERATIVO,
            ],
            [
                'FUNCION' => 'PERSONAL ADMINISTRATIVO OPERATIVO',
                'ESTADO_FUNCION' => 'Activo',
                'ID_GRUPO_OPERATIVO' => $grupoOperativo->ID_GRUPO_OPERATIVO,
            ]
        ];

        $funcionesIds = [];
        foreach ($funciones as $funcionData) {
            $funcion = Funcione::create($funcionData);
            $funcionesIds[$funcionData['FUNCION']] = $funcion->ID_FUNCION;
        }

        // Crear personas basadas en las órdenes de servicio
        $personas = [
            // Gerencia
            [
                'ID_DISTRITO_AGENTE' => $distrito->ID_DISTRITO_AGENTE,
                'ID_FUNCION' => $funcionesIds['GERENTE OPERATIVO DE TRÁNSITO'],
                'CEDULA' => '0101010101',
                'NOMBRES' => 'MARLON',
                'APELLIDOS' => 'POZO',
                'CODIGO_AGENTE' => 'GO001',
                'TELEFONO_AGENTE' => '0990000001',
                'AGENTE' => 'TCNL.(SP) MARLON POZO',
                'EMAIL' => 'marlon.pozo@epm.gob.ec',
                'ESTADO' => 'Activo',
            ],
            [
                'ID_DISTRITO_AGENTE' => $distrito->ID_DISTRITO_AGENTE,
                'ID_FUNCION' => $funcionesIds['JEFE DE TRÁNSITO'],
                'CEDULA' => '0101010102',
                'NOMBRES' => 'GISELA',
                'APELLIDOS' => 'LOBATO',
                'CODIGO_AGENTE' => 'JT001',
                'TELEFONO_AGENTE' => '0990000002',
                'AGENTE' => 'LOBATO GISELA',
                'EMAIL' => 'gisela.lobato@epm.gob.ec',
                'ESTADO' => 'Activo',
            ],
            [
                'ID_DISTRITO_AGENTE' => $distrito->ID_DISTRITO_AGENTE,
                'ID_FUNCION' => $funcionesIds['SUB JEFE DE TRÁNSITO'],
                'CEDULA' => '0101010103',
                'NOMBRES' => 'ABIGAIL',
                'APELLIDOS' => 'AMAGUAÑA',
                'CODIGO_AGENTE' => 'SJT001',
                'TELEFONO_AGENTE' => '0990000003',
                'AGENTE' => 'AMAGUAÑA ABIGAIL',
                'EMAIL' => 'abigail.amaguana@epm.gob.ec',
                'ESTADO' => 'Activo',
            ],
            
            // Inspectores de Distrito
            [
                'ID_DISTRITO_AGENTE' => $distrito->ID_DISTRITO_AGENTE,
                'ID_FUNCION' => $funcionesIds['INSPECTOR DISTRITO CENTRO'],
                'CEDULA' => '0101010104',
                'NOMBRES' => 'ANDRÉS',
                'APELLIDOS' => 'VILLARRUEL',
                'CODIGO_AGENTE' => 'IDC001',
                'TELEFONO_AGENTE' => '0990000004',
                'AGENTE' => 'VILLARRUEL ANDRÉS',
                'EMAIL' => 'andres.villarruel@epm.gob.ec',
                'ESTADO' => 'Activo',
            ],
            [
                'ID_DISTRITO_AGENTE' => $distrito->ID_DISTRITO_AGENTE,
                'ID_FUNCION' => $funcionesIds['INSPECTOR DISTRITO SUR'],
                'CEDULA' => '0101010105',
                'NOMBRES' => 'JEFFERSON',
                'APELLIDOS' => 'PASTRANA',
                'CODIGO_AGENTE' => 'IDS001',
                'TELEFONO_AGENTE' => '0990000005',
                'AGENTE' => 'PASTRANA JEFFERSON',
                'EMAIL' => 'jefferson.pastrana@epm.gob.ec',
                'ESTADO' => 'Activo',
            ],
            [
                'ID_DISTRITO_AGENTE' => $distrito->ID_DISTRITO_AGENTE,
                'ID_FUNCION' => $funcionesIds['INSPECTOR DISTRITO NORTE'],
                'CEDULA' => '0101010106',
                'NOMBRES' => 'SANTIAGO',
                'APELLIDOS' => 'REYES',
                'CODIGO_AGENTE' => 'IDN001',
                'TELEFONO_AGENTE' => '0990000006',
                'AGENTE' => 'REYES SANTIAGO',
                'EMAIL' => 'santiago.reyes@epm.gob.ec',
                'ESTADO' => 'Activo',
            ],
            [
                'ID_DISTRITO_AGENTE' => $distrito->ID_DISTRITO_AGENTE,
                'ID_FUNCION' => $funcionesIds['SUB INSPECTOR CANTÓN'],
                'CEDULA' => '0101010107',
                'NOMBRES' => 'ANDERSON',
                'APELLIDOS' => 'CALDERON',
                'CODIGO_AGENTE' => 'SIC001',
                'TELEFONO_AGENTE' => '0990000007',
                'AGENTE' => 'CALDERON ANDERSON',
                'EMAIL' => 'anderson.calderon@epm.gob.ec',
                'ESTADO' => 'Activo',
            ],
            
            // Conductores
            [
                'ID_DISTRITO_AGENTE' => $distrito->ID_DISTRITO_AGENTE,
                'ID_FUNCION' => $funcionesIds['CONDUCTOR GERENTE OPERATIVO DE TRÁNSITO'],
                'CEDULA' => '0101010108',
                'NOMBRES' => 'RICHARD',
                'APELLIDOS' => 'TOBAR',
                'CODIGO_AGENTE' => 'CGO001',
                'TELEFONO_AGENTE' => '0990000008',
                'AGENTE' => 'TOBAR RICHARD',
                'EMAIL' => 'richard.tobar@epm.gob.ec',
                'ESTADO' => 'Activo',
            ],
            [
                'ID_DISTRITO_AGENTE' => $distrito->ID_DISTRITO_AGENTE,
                'ID_FUNCION' => $funcionesIds['CONDUCTOR SUB JEFE DE TRÁNSITO'],
                'CEDULA' => '0101010109',
                'NOMBRES' => 'ALEJANDRO',
                'APELLIDOS' => 'HUERTAS',
                'CODIGO_AGENTE' => 'CJT001',
                'TELEFONO_AGENTE' => '0990000009',
                'AGENTE' => 'HUERTAS ALEJANDRO',
                'EMAIL' => 'alejandro.huertas@epm.gob.ec',
                'ESTADO' => 'Activo',
            ],
            
            // Personal de Control
            [
                'ID_DISTRITO_AGENTE' => $distrito->ID_DISTRITO_AGENTE,
                'ID_FUNCION' => $funcionesIds['INSPECTOR DE CONTROL GENERAL'],
                'CEDULA' => '0101010110',
                'NOMBRES' => 'LUIS',
                'APELLIDOS' => 'ORDOÑEZ',
                'CODIGO_AGENTE' => 'ICG001',
                'TELEFONO_AGENTE' => '0990000010',
                'AGENTE' => 'ORDOÑEZ LUIS',
                'EMAIL' => 'luis.ordonez@epm.gob.ec',
                'ESTADO' => 'Activo',
            ],
            [
                'ID_DISTRITO_AGENTE' => $distrito->ID_DISTRITO_AGENTE,
                'ID_FUNCION' => $funcionesIds['SUB INSPECTOR DE CONTROL GENERAL'],
                'CEDULA' => '0101010111',
                'NOMBRES' => 'LILIAN',
                'APELLIDOS' => 'FRAGA',
                'CODIGO_AGENTE' => 'SICG001',
                'TELEFONO_AGENTE' => '0990000011',
                'AGENTE' => 'FRAGA LILIAN',
                'EMAIL' => 'lilian.fraga@epm.gob.ec',
                'ESTADO' => 'Activo',
            ],
            [
                'ID_DISTRITO_AGENTE' => $distrito->ID_DISTRITO_AGENTE,
                'ID_FUNCION' => $funcionesIds['PERSONAL ADMINISTRATIVO OPERATIVO'],
                'CEDULA' => '0101010112',
                'NOMBRES' => 'ROSARIO',
                'APELLIDOS' => 'GUANANGA',
                'CODIGO_AGENTE' => 'PAO001',
                'TELEFONO_AGENTE' => '0990000012',
                'AGENTE' => 'GUANANGA ROSARIO',
                'EMAIL' => 'rosario.guananga@epm.gob.ec',
                'ESTADO' => 'Activo',
            ]
        ];

        $personasIds = [];
        foreach ($personas as $personaData) {
            $persona = Persona::create($personaData);
            $personasIds[$persona->CODIGO_AGENTE] = $persona->ID_PERSONA;
            
            // Crear usuario para cada persona
            if ($personaData['ID_FUNCION'] === $funcionesIds['Gerente Operativo']) {
                $usuario = Usuario::create([
                    'ID_PERSONA' => $persona->ID_PERSONA,
                    'USUARIO' => strtolower(str_replace(' ', '.', $persona->NOMBRES . '.' . $persona->APELLIDOS)),
                    'PASS' => Hash::make('password'),
                    'ESTADO' => 'Activo',
                    'HASH' => Hash::make(now() . $persona->ID_PERSONA),
                    'FECHA' => now(),
                ]);

                // Asignar sistema al usuario
                UsuarioSistema::create([
                    'ID_SISTEMA' => $sistema->ID_SISTEMA,
                    'ID_USUARIO' => $usuario->ID_USUARIO,
                    'ESTADO_USUARIO_SISTEMA' => 'Activo',
                ]);
            }
        }

        // Crear tipo de indisponibilidad
        $tipoIndisponibilidad = TipoIndisponibilidad::create([
            'TIPO_INDISPONIBILIDAD' => 'Vacaciones',
            'ESTADO' => 'Activo',
        ]);

        // Crear indisponibilidad
        $indisponibilidad = Indisponibilidad::create([
            'ID_PERSONA' => $persona->ID_PERSONA,
            'ID_TIPO_INDISPONIBILIDAD' => $tipoIndisponibilidad->ID_TIPO_INDISPONIBILIDAD,
            'FECHA_INICIO' => now(),
            'FECHA_FIN' => now()->addDays(7),
            'MOTIVO' => 'Vacaciones programadas',
            'ESTADO' => 'Activo',
        ]);

        // Crear sistema
        $sistema = Sistema::create([
            'NOMBRE_SISTEMA' => 'OSGO',
            'ESTADO_SISTEMA' => 'Activo',
        ]);

        // Crear usuario
        $usuario = Usuario::create([
            'ID_PERSONA' => $persona->ID_PERSONA,
            'USUARIO' => 'admin',
            'PASS' => Hash::make('password'),
            'ESTADO' => 'Activo',
            'HASH' => Hash::make(now()),
            'FECHA' => now(),
        ]);

        // Asignar sistema al usuario
        UsuarioSistema::create([
            'ID_SISTEMA' => $sistema->ID_SISTEMA,
            'ID_USUARIO' => $usuario->ID_USUARIO,
            'ESTADO_USUARIO_SISTEMA' => 'Activo',
        ]);
    }
}
