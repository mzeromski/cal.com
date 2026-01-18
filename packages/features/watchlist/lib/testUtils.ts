import type { WatchlistType } from "@calcom/prisma/enums";
import prismock from "@calcom/testing/lib/__mocks__/prisma";

interface WatchlistInput {
  type: WatchlistType;
  value: string;
}

export const createWatchlistEntry = async (input: WatchlistInput) => {
  await prismock.watchlist.create({
    data: {
      ...input,
    },
  });
};
