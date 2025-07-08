import { WebPlugin } from '@capacitor/core';

import type { GetLocalIPPlugin } from './definitions';

export class GetLocalIPWeb extends WebPlugin implements GetLocalIPPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
