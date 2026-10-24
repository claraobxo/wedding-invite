# Invite Studio — setup

This is a customizable invitation builder, not a pre-made wedding invite. It supports PDF upload, envelope colour/pattern selection, a Joy link, saving drafts, and publishing a single guest URL.

## One-time setup
1. Create a free Supabase project at https://supabase.com.
2. In Supabase **SQL Editor**, run all of `supabase.sql`.
3. In Supabase **Project Settings → API**, copy the Project URL and anon/public key.
4. In both `index.html` and `invite.html`, replace:
   - `PASTE_SUPABASE_PROJECT_URL` with your project URL
   - `PASTE_SUPABASE_ANON_KEY` with the anon/public key
   (Do not use the service-role key in a website.)
5. Upload `index.html`, `invite.html`, and `supabase.sql` to your GitHub repo root. Keep the Pages deployment set to `main` / root.

## Use it
- Open the builder URL, enter your email and password, and click **Sign in**. First use signs you up; if email confirmation is enabled, confirm the email and sign in.
- Upload the invitation PDF, choose envelope colour and pattern, add the Joy URL, and save.
- Click **Publish / update guest link** to create the public invitation URL. Add that URL to Joy.
- To edit, sign in, choose a saved invitation, make changes, save, then publish/update again.

## Notes
- This is a client-side static site plus Supabase. The Supabase anon key is designed to be public; table/storage policies in `supabase.sql` restrict editing to the signed-in owner and public access to published invitations.
- The current builder includes built-in envelope pattern swatches. Uploading a custom liner image is preview-only in this initial version; custom image persistence and drag/drop invitation composition are not yet implemented.
- Supabase free-plan quotas and availability are controlled by Supabase.
