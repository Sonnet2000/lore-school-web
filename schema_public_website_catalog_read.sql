-- Loré Fondation — Aksè PIBLIK (san moun konekte) pou katalòg kou yo
-- pou paj "Centre de Formation en Informatique" sou lorefondation.com.
--
-- POUKISA fichye sa a nesesè: tout lòt "policy" sou "programs"/"courses"
-- (gade schema_programs.sql, schema_course_catalog.sql) mande
-- "auth.uid() is not null" — se sèl moun ki KONEKTE nan app la ka li
-- yo. Paj piblik sit la (index.html), li menm, pa gen moun konekte
-- (yon vizitè òdinè ki poko gen kont), kidonk li bezwen pwòp "policy"
-- pa li, pou wòl "anon" (piblik), ki AJOUTE sou sa ki deja egziste yo
-- san l pa retire/ranplase yo.
--
-- SEKIRITE: sa a louvri SÈLMAN lekti (SELECT), SÈLMAN pou kou ki
-- "pibliye" (is_published = true) ak filyè ki "aktif" (is_active =
-- true) — menm done ki deja parèt nan katalòg app mobil la pou tout
-- elèv. Okenn done sansib (pwofil, nòt, peman, elatriye) pa konsène.
--
-- Kouri sa nan SQL Editor Supabase la, apre schema_programs.sql ak
-- schema_course_catalog.sql. Idempotan — ou ka egzekite l plizyè fwa
-- san danje.

-- ============================================================
-- 1) FILYÈ (programs) — lekti piblik pou filyè aktif yo sèlman
-- ============================================================
drop policy if exists "programs_public_select" on public.programs;
create policy "programs_public_select"
  on public.programs for select
  to anon
  using (is_active = true);

-- ============================================================
-- 2) KOU (courses) — lekti piblik pou kou pibliye yo sèlman
-- ============================================================
drop policy if exists "courses_public_catalog_select" on public.courses;
create policy "courses_public_catalog_select"
  on public.courses for select
  to anon
  using (is_published = true);

-- NÒT: paj piblik la (index.html) SÈLMAN mande kolòn ki pa sansib
-- (non, deskripsyon, pri, dire, orè, elatriye) e li PA mande "teacher:
-- profiles(full_name)" tankou app la fè l — sa ta mande yon aksè piblik
-- sou tab "profiles" tou, ki gen twòp lòt kolòn sansib pou n louvri l
-- bay "anon". Si nou vle non pwofesè a parèt sou sit la yon jou, pi bon
-- fason an se ajoute yon kolòn "teacher_display_name" dirèkteman sou
-- "courses" (kontwole pa Admin), pa louvri "profiles" bay piblik la.

-- ============================================================
-- VERIFIKASYON RAPID apre ou egzekite sa a:
-- 1. San ou pa konekte okenn kote, teste nan navigatè oswa "curl" sa a
--    (ranplase pa vrè URL pwojè a ak kle "anon" piblik la):
--      curl "https://afvqvorexojvjpjxiabu.supabase.co/rest/v1/courses?select=id,name,description,price,duration_label,schedule_label,program_id&is_published=eq.true" \
--        -H "apikey: VOTRE_CLE_ANON" -H "Authorization: Bearer VOTRE_CLE_ANON"
-- 2. Ou dwe wè lis kou pibliye yo an JSON — san erè 401/403.
-- 3. Rekonekte kòm Elèv nan app mobil la → "Katalòg Kou" dwe kontinye
--    mache menm jan an (policy sa a ADISYONE, li pa retire anyen).
-- ============================================================
