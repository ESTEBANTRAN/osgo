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

        // Crear función
        $funcion = Funcione::create([
            'FUNCION' => 'Operador',
            'ESTADO_FUNCION' => 'Activo',
            'ID_GRUPO_OPERATIVO' => $grupoOperativo->ID_GRUPO_OPERATIVO,
        ]);

        // Crear persona
        $persona = Persona::create([
            'ID_DISTRITO_AGENTE' => $distrito->ID_DISTRITO_AGENTE,
            'ID_FUNCION' => $funcion->ID_FUNCION,
            'CEDULA' => '1234567890',
            'NOMBRES' => 'Juan',
            'APELLIDOS' => 'Pérez',
            'DIRECCION' => 'Av. Principal 123',
            'TELEFONO' => '0999999999',
            'CORREO' => 'juan.perez@example.com',
            'ESTADO' => 'Activo',
        ]);

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
