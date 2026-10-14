-- Tabela de notas do Caderno de Tags.
-- Cole tudo no Supabase em SQL Editor → New query → Run.

create table if not exists public.notes (
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  id text not null,
  data jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, id)
);

-- Cada pessoa só enxerga e altera as próprias notas.
alter table public.notes enable row level security;

drop policy if exists "ler as próprias notas" on public.notes;
drop policy if exists "criar as próprias notas" on public.notes;
drop policy if exists "editar as próprias notas" on public.notes;
drop policy if exists "apagar as próprias notas" on public.notes;

create policy "ler as próprias notas" on public.notes
  for select using (auth.uid() = user_id);
create policy "criar as próprias notas" on public.notes
  for insert with check (auth.uid() = user_id);
create policy "editar as próprias notas" on public.notes
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "apagar as próprias notas" on public.notes
  for delete using (auth.uid() = user_id);
