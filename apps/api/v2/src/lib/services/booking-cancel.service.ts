import { BookingCancelService as BaseBookingCancelService } from "@calcom/platform-libraries/bookings";
import { Injectable } from "@nestjs/common";
import { PrismaWriteService } from "@/modules/prisma/prisma-write.service";

@Injectable()
export class BookingCancelService extends BaseBookingCancelService {
  constructor(prismaWriteService: PrismaWriteService) {
    super({
      prismaClient: prismaWriteService.prisma,
    });
  }
}
