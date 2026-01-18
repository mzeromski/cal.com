import { Module } from "@nestjs/common";
import { oAuthServiceModule } from "@/lib/modules/oauth.module";
import { OAuth2Controller } from "@/modules/auth/oauth2/controllers/oauth2.controller";

@Module({
  imports: [oAuthServiceModule],
  controllers: [OAuth2Controller],
})
export class OAuth2Module {}
