-- Loré Fondation — Done REYÈL pou kou Enfòmatik yo (soti nan flyer ofisyèl
-- la), pou yo antre nan menm baz done ke app mobil la ak Admin sèvi a —
-- olye yo rete sèlman nan yon imaj oswa yon lis tanporè sou sit la.
--
-- Sa a ranpli 4 KOU (courses) anba filyè "Informatique & Bureautique"
-- (code = 'INFO', deja kreye pa schema_programs_seed.sql) :
--   1. Technique Informatique        — 12 mwa, an semèn (vakasyon AM/PM)
--   2. Informatique Bureautique      — 6 mwa,  an semèn (vakasyon AM/PM)
--   3. Photographie & Infographie    — 6 mwa,  wikenn
--   4. Intelligence Artificielle     — 4 mwa,  wikenn SÈLMAN (pwogram apa)
--
-- Frè: 1 000 HTG enskripsyon (registration_fee) + 2 500 HTG akseswa
-- (maillot + badge, accessories_fee) — menm valè ki nan flyer ak fòm
-- enskripsyon an liy lan.
--
-- Kouri sa apre schema_programs_seed.sql, nan SQL Editor Supabase.
-- Idempotan — ou ka egzekite l plizyè fwa san danje (li verifye si kou a
-- deja egziste anba menm filyè a anvan li kreye l ankò).

do $$
declare
  v_program_id uuid;
begin
  select id into v_program_id from public.programs where code = 'INFO';

  if v_program_id is null then
    raise notice 'Filyè "INFO" (Informatique & Bureautique) pa jwenn — kouri schema_programs_seed.sql anvan.';
  else

    if not exists (select 1 from public.courses where program_id = v_program_id and name = 'Technique Informatique') then
      insert into public.courses
        (name, program_id, description, content, duration_label, schedule_label,
         registration_fee, accessories_fee, fee_type, is_published)
      values
        ('Technique Informatique', v_program_id,
         'Maintenance, réseaux et systèmes — pour devenir un professionnel complet de l''informatique.',
         '20% théorie / 80% pratique',
         '12 mois', 'En semaine (vacation AM/PM)',
         1000, 2500, 'total', true);
    end if;

    if not exists (select 1 from public.courses where program_id = v_program_id and name = 'Informatique Bureautique') then
      insert into public.courses
        (name, program_id, description, content, duration_label, schedule_label,
         registration_fee, accessories_fee, fee_type, is_published)
      values
        ('Informatique Bureautique', v_program_id,
         'Word, Excel, PowerPoint et les outils numériques essentiels au monde professionnel.',
         '20% théorie / 80% pratique',
         '6 mois', 'En semaine (vacation AM/PM)',
         1000, 2500, 'total', true);
    end if;

    if not exists (select 1 from public.courses where program_id = v_program_id and name = 'Photographie & Infographie') then
      insert into public.courses
        (name, program_id, description, content, duration_label, schedule_label,
         registration_fee, accessories_fee, fee_type, is_published)
      values
        ('Photographie & Infographie', v_program_id,
         'Prise de vue, composition, retouche numérique et infographie appliquée.',
         '20% théorie / 80% pratique',
         '6 mois', 'En week-end',
         1000, 2500, 'total', true);
    end if;

    if not exists (select 1 from public.courses where program_id = v_program_id and name = 'Intelligence Artificielle') then
      insert into public.courses
        (name, program_id, description, content, duration_label, schedule_label,
         registration_fee, accessories_fee, fee_type, is_published)
      values
        ('Intelligence Artificielle', v_program_id,
         'Bases de l''IA, automatisation et outils intelligents appliqués au travail.',
         '20% théorie / 80% pratique — programme à part, uniquement le week-end',
         '4 mois', 'En week-end seulement',
         1000, 2500, 'total', true);
    end if;

  end if;
end $$;

-- ============================================================
-- VERIFIKASYON RAPID apre ou egzekite sa a:
-- 1. Nan admin-cours.html oswa Admin → Kou (app mobil), ou dwe wè 4 nouvo
--    kou yo anba filyè "Informatique & Bureautique", chak ak bon dire,
--    orè, ak frè (1 000 HTG + 2 500 HTG akseswa).
-- 2. Si ou egzekite tou schema_public_website_catalog_read.sql, kou yo
--    ap parèt otomatikman nan katalòg piblik sit la (index.html) san ou
--    pa bezwen touche kòd la ankò.
-- ============================================================
