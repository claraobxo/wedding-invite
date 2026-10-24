-- Run this in Supabase Dashboard > SQL Editor
create table if not exists public.invitations (
 id uuid primary key default gen_random_uuid(),
 owner_id uuid not null references auth.users(id) on delete cascade,
 title text not null default 'Untitled invitation',
 monogram text,
 envelope_color text,
 pattern text,
 joy_url text,
 joy_label text,
 pdf_path text,
 public_slug text unique,
 is_published boolean not null default false,
 created_at timestamptz not null default now()
);
alter table public.invitations enable row level security;
create policy "Owners can view their invitations" on public.invitations for select to authenticated using (auth.uid() = owner_id);
create policy "Owners can create invitations" on public.invitations for insert to authenticated with check (auth.uid() = owner_id);
create policy "Owners can update invitations" on public.invitations for update to authenticated using (auth.uid() = owner_id) with check (auth.uid() = owner_id);
create policy "Public can view published invitations" on public.invitations for select to anon, authenticated using (is_published = true);

insert into storage.buckets (id, name, public) values ('invite-files','invite-files',true) on conflict (id) do nothing;
create policy "Authenticated users upload invite PDFs" on storage.objects for insert to authenticated with check (bucket_id='invite-files' and (storage.foldername(name))[1]=auth.uid()::text);
create policy "Public can read invite PDFs" on storage.objects for select to anon, authenticated using (bucket_id='invite-files');
create policy "Owners update their invite PDFs" on storage.objects for update to authenticated using (bucket_id='invite-files' and (storage.foldername(name))[1]=auth.uid()::text) with check (bucket_id='invite-files' and (storage.foldername(name))[1]=auth.uid()::text);
