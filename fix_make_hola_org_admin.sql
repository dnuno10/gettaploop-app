-- Ejecutar en Supabase SQL Editor.
-- Da permisos de administrador de organizacion al usuario hola@gettaploop.com.

UPDATE public.users
SET role = 'admin'
WHERE lower(email) = 'hola@gettaploop.com';

NOTIFY pgrst, 'reload schema';

-- Verificacion esperada: role debe salir como admin.
SELECT id, org_id, email, role, is_active
FROM public.users
WHERE lower(email) = 'hola@gettaploop.com';
