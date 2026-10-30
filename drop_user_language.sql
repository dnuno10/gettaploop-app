-- Ejecutar en Supabase SQL Editor.
--
-- Revierte add_user_language.sql: quita la columna "language" que se había
-- agregado a public.users para el idioma del perfil digital público
-- (funcionalidad que se removió del código de la app).
--
-- IF EXISTS evita error si por alguna razón ya no existiera. No afecta
-- ningún otro dato de ningún usuario.

ALTER TABLE public.users
DROP COLUMN IF EXISTS language;

NOTIFY pgrst, 'reload schema';
