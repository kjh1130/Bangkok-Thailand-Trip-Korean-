-- 방콕 지도 일정 동기화용 테이블. Supabase 대시보드 > SQL Editor에 붙여넣고 Run.
create table if not exists public.schedules (
  id text primary key,
  days jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.schedules enable row level security;

-- 로그인 없이 쓰는 지도라서, 사이트 주소를 아는 사람은 누구나 이 표를 읽고 고칠 수 있다.
-- 일정 외의 정보는 이 표에 넣지 말 것.
create policy "anyone can read schedules" on public.schedules for select to anon using (true);
create policy "anyone can insert schedules" on public.schedules for insert to anon with check (true);
create policy "anyone can update schedules" on public.schedules for update to anon using (true) with check (true);
