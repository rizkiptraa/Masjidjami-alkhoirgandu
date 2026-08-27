
create extension if not exists pgcrypto;
create table if not exists public.events (
  id uuid primary key default gen_random_uuid(), title text not null,
  category text not null default 'Umum', event_date date not null,
  description text default '', image_url text default '', image_urls jsonb not null default '[]'::jsonb,
  published boolean not null default true, created_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now()
);
alter table public.events enable row level security;
drop policy if exists "Public can read published events" on public.events;
create policy "Public can read published events" on public.events for select using (published=true or (auth.jwt()->>'email') in ('masjidalkhoirgandu@gmail.com','rizkiku255@gmail.com'));
drop policy if exists "Admins can insert events" on public.events;
create policy "Admins can insert events" on public.events for insert with check ((auth.jwt()->>'email') in ('masjidalkhoirgandu@gmail.com','rizkiku255@gmail.com'));
drop policy if exists "Admins can update events" on public.events;
create policy "Admins can update events" on public.events for update using ((auth.jwt()->>'email') in ('masjidalkhoirgandu@gmail.com','rizkiku255@gmail.com')) with check ((auth.jwt()->>'email') in ('masjidalkhoirgandu@gmail.com','rizkiku255@gmail.com'));
drop policy if exists "Admins can delete events" on public.events;
create policy "Admins can delete events" on public.events for delete using ((auth.jwt()->>'email') in ('masjidalkhoirgandu@gmail.com','rizkiku255@gmail.com'));

insert into storage.buckets (id,name,public) values ('event-images','event-images',true) on conflict (id) do nothing;
drop policy if exists "Public read event images" on storage.objects;
create policy "Public read event images" on storage.objects for select using (bucket_id='event-images');
drop policy if exists "Admins upload event images" on storage.objects;
create policy "Admins upload event images" on storage.objects for insert with check (bucket_id='event-images' and (auth.jwt()->>'email') in ('masjidalkhoirgandu@gmail.com','rizkiku255@gmail.com'));
drop policy if exists "Admins update event images" on storage.objects;
create policy "Admins update event images" on storage.objects for update using (bucket_id='event-images' and (auth.jwt()->>'email') in ('masjidalkhoirgandu@gmail.com','rizkiku255@gmail.com'));
drop policy if exists "Admins delete event images" on storage.objects;
create policy "Admins delete event images" on storage.objects for delete using (bucket_id='event-images' and (auth.jwt()->>'email') in ('masjidalkhoirgandu@gmail.com','rizkiku255@gmail.com'));

create table if not exists public.site_content (
 id integer primary key default 1 check(id=1), phone text default '', donation text default '',
 virtual_tour_url text default '', history text default '', updated_by uuid references auth.users(id) on delete set null,
 updated_at timestamptz not null default now()
);
alter table public.site_content enable row level security;
drop policy if exists "Public can read site content" on public.site_content;
create policy "Public can read site content" on public.site_content for select using (true);
drop policy if exists "Admins can insert site content" on public.site_content;
create policy "Admins can insert site content" on public.site_content for insert with check ((auth.jwt()->>'email') in ('masjidalkhoirgandu@gmail.com','rizkiku255@gmail.com'));
drop policy if exists "Admins can update site content" on public.site_content;
create policy "Admins can update site content" on public.site_content for update using ((auth.jwt()->>'email') in ('masjidalkhoirgandu@gmail.com','rizkiku255@gmail.com')) with check ((auth.jwt()->>'email') in ('masjidalkhoirgandu@gmail.com','rizkiku255@gmail.com'));
