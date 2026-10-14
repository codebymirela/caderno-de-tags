-- Imagens das notas do Caderno de Tags.
-- Cole tudo no Supabase em SQL Editor → New query → Run (só precisa rodar uma vez).

-- Pasta privada "imagens", com limite de 5 MB por arquivo.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('imagens', 'imagens', false, 5242880, array['image/png', 'image/jpeg', 'image/webp', 'image/gif'])
on conflict (id) do update
  set public = false,
      file_size_limit = excluded.file_size_limit,
      allowed_mime_types = excluded.allowed_mime_types;

-- Cada pessoa só vê, envia e apaga imagens dentro da própria pasta (o nome da pasta é o id da conta).
drop policy if exists "ver as próprias imagens" on storage.objects;
drop policy if exists "enviar as próprias imagens" on storage.objects;
drop policy if exists "apagar as próprias imagens" on storage.objects;

create policy "ver as próprias imagens" on storage.objects
  for select to authenticated
  using (bucket_id = 'imagens' and (storage.foldername(name))[1] = (select auth.uid())::text);

create policy "enviar as próprias imagens" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'imagens' and (storage.foldername(name))[1] = (select auth.uid())::text);

create policy "apagar as próprias imagens" on storage.objects
  for delete to authenticated
  using (bucket_id = 'imagens' and (storage.foldername(name))[1] = (select auth.uid())::text);
