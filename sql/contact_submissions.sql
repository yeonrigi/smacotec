-- Supabase SQL Editor에서 실행하세요 (Project > SQL Editor > New query)

create table if not exists contact_submissions (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text not null,
  message text not null,
  created_at timestamptz not null default now()
);

alter table contact_submissions enable row level security;

-- 익명 사용자(웹사이트 방문자)는 새 문의를 "추가"만 할 수 있고, 조회/수정/삭제는 불가능
drop policy if exists "Allow public insert" on contact_submissions;

create policy "Allow public insert" on contact_submissions
  for insert
  to public
  with check (true);
